#!/usr/bin/env bash

set -euo pipefail

# --- CI/non-interactive bypass ---
NONINTERACTIVE="${INIT_NONINTERACTIVE:-0}"


# Interactive project setup script
# Run after cloning from the template: just init

BOLD='\033[1m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BOLD}🚀 Project Setup${NC}"
echo ""

# --- Detect platform for sed compatibility ---

if [[ "$(uname)" == "Darwin" ]]; then
    sedi() { sed -i '' "$@"; }
else
    sedi() { sed -i "$@"; }
fi

# --- Prompts ---

echo ""

if [[ "$NONINTERACTIVE" == "1" ]]; then
    PROJECT_NAME="${PROJECT_NAME:-project-template}"
    PACKAGE_NAME="${PROJECT_NAME//-/_}"
    DESCRIPTION="${DESCRIPTION:-A short description of your project}"
    AUTHOR_NAME="${AUTHOR_NAME:-Your Name}"
    AUTHOR_EMAIL="${AUTHOR_EMAIL:-your-email@example.com}"
    GITHUB_USER="${GITHUB_USER:-your-username}"
    INIT_DVC="n"
    INIT_ENV="n"
    INIT_ML="n"
    INIT_SECURITY="y"
    INIT_PRECOMMIT="y"
    INIT_DOCS="y"
    INIT_DOCKER="y"
    INIT_CI="y"
    INIT_NOTEBOOK="n"
    INIT_EXDATA="n"
else
    read -rp "Project name (kebab-case, e.g. my-ml-project): " PROJECT_NAME
    if [[ -z "$PROJECT_NAME" ]]; then
            echo "Error: project name is required."
            exit 1
    fi
    PACKAGE_NAME="${PROJECT_NAME//-/_}"
    read -rp "Short description: " DESCRIPTION
    read -rp "Author name: " AUTHOR_NAME
    read -rp "Author email: " AUTHOR_EMAIL
    read -rp "GitHub username or org: " GITHUB_USER
    echo ""
    read -rp "Initialize DVC for data versioning? (y/N): " INIT_DVC
    read -rp "Create .env from .env.example? (y/N): " INIT_ENV
    read -rp "Include ML/AI packages ([ml] extras)? (y/N): " INIT_ML
    read -rp "Enable security hardening (pre-commit, Ruff, mypy, audit)? (Y/n): " INIT_SECURITY
    read -rp "Enable pre-commit hooks? (Y/n): " INIT_PRECOMMIT
    read -rp "Include documentation tooling (MkDocs)? (Y/n): " INIT_DOCS
    read -rp "Include Docker support (Dockerfile, Compose)? (Y/n): " INIT_DOCKER
    read -rp "Include CI/CD workflows (GitHub Actions)? (Y/n): " INIT_CI
    read -rp "Include Jupyter/Notebook support? (y/N): " INIT_NOTEBOOK
    read -rp "Add example/test data to data/? (y/N): " INIT_EXDATA
fi

echo ""
echo -e "${CYAN}Setting up ${BOLD}${PROJECT_NAME}${NC}${CYAN} (package: ${PACKAGE_NAME})...${NC}"
echo ""

# --- Rename package directory ---

if [[ -d "src/project_name" && "$PACKAGE_NAME" != "project_name" ]]; then
    mv "src/project_name" "src/${PACKAGE_NAME}"
    # Stage the rename so git ls-files returns the new paths
    git add -A
    echo -e "  ${GREEN}✓${NC} Renamed src/project_name → src/${PACKAGE_NAME}"
fi

# --- Find and replace across all files ---

find_and_replace() {
    local old="$1"
    local new="$2"
    # Use git ls-files to only touch tracked text files
    while IFS= read -r -d '' file; do
        if [[ -f "$file" ]] && file --brief "$file" | grep -q text; then
            sedi "s|${old}|${new}|g" "$file" 2>/dev/null || true
        fi
    done < <(git ls-files -z)
}

find_and_replace "project-name" "$PROJECT_NAME"
find_and_replace "project_name" "$PACKAGE_NAME"
find_and_replace "A short description of your project" "$DESCRIPTION"
find_and_replace "your-username" "$GITHUB_USER"
find_and_replace "your-repo" "$PROJECT_NAME"
find_and_replace "your-email@example.com" "$AUTHOR_EMAIL"
find_and_replace "namitdeb739/python-template" "${GITHUB_USER}/${PROJECT_NAME}"
find_and_replace "namitdeb739.github.io/python-template" "${GITHUB_USER}.github.io/${PROJECT_NAME}"

echo -e "  ${GREEN}✓${NC} Updated project references across all files"

# --- Update pyproject.toml author ---

if ! grep -q "authors" pyproject.toml; then
    sedi "/^description/a\\
authors = [{name = \"${AUTHOR_NAME}\", email = \"${AUTHOR_EMAIL}\"}]" pyproject.toml
    echo -e "  ${GREEN}✓${NC} Added author to pyproject.toml"
fi

# --- Update LICENSE copyright ---

YEAR=$(date +%Y)
sedi "s/Copyright (c) [0-9]* ${PROJECT_NAME} contributors/Copyright (c) ${YEAR} ${AUTHOR_NAME}/" LICENSE 2>/dev/null || true
echo -e "  ${GREEN}✓${NC} Updated LICENSE copyright"

echo ""
echo -e "${CYAN}Installing dependencies...${NC}"
git config core.longpaths true
echo -e "  ${GREEN}✓${NC} Dependencies locked and installed"
echo -e "  ${GREEN}✓${NC} Pre-commit hooks installed"

# --- Optional: DVC ---
if [[ "${INIT_DVC,,}" == "y" ]]; then
    if command -v dvc &>/dev/null || uv run dvc version &>/dev/null 2>&1; then
        uv run dvc init
        uv run dvc config core.autostage true
        echo -e "  ${GREEN}✓${NC} Initialized DVC"
    else
        echo "  ⚠ DVC not installed. Uncomment 'dvc' in pyproject.toml [ml] extras and run: uv sync --extra ml"
    fi
fi

# --- Optional: .env ---
if [[ "${INIT_ENV,,}" == "y" ]]; then
    cp .env.example .env
    echo -e "  ${GREEN}✓${NC} Created .env from .env.example (fill in your API keys)"
fi

# --- Optional: ML/AI packages ---
if [[ "${INIT_ML,,}" == "y" ]]; then
    uv sync --extra ml
    echo -e "  ${GREEN}✓${NC} ML/AI packages ([ml] extras) installed"
fi

# --- Optional: Security hardening ---
if [[ "${INIT_SECURITY,,}" != "n" ]]; then
    uv run pre-commit install
    uv run ruff check src/ tests/
    uv run mypy src/
    uv run pip-audit
    echo -e "  ${GREEN}✓${NC} Security hardening tools enabled"
fi

# --- Optional: Pre-commit hooks ---
if [[ "${INIT_PRECOMMIT,,}" != "n" ]]; then
    uv run pre-commit install
    echo -e "  ${GREEN}✓${NC} Pre-commit hooks installed"
fi

# --- Optional: Documentation ---
if [[ "${INIT_DOCS,,}" != "n" ]]; then
    uv run mkdocs build
    echo -e "  ${GREEN}✓${NC} Documentation tooling enabled"
fi

# --- Optional: Docker ---
if [[ "${INIT_DOCKER,,}" != "n" ]]; then
    docker --version && echo -e "  ${GREEN}✓${NC} Docker support enabled (Dockerfile, Compose)"
fi

# --- Optional: CI/CD ---
if [[ "${INIT_CI,,}" != "n" ]]; then
    echo -e "  ${GREEN}✓${NC} CI/CD workflows included (GitHub Actions)"
fi

# --- Optional: Jupyter/Notebook ---
if [[ "${INIT_NOTEBOOK,,}" == "y" ]]; then
    uv run jupyter notebook --version
    echo -e "  ${GREEN}✓${NC} Jupyter/Notebook support enabled"
fi

# --- Optional: Example/test data ---
if [[ "${INIT_EXDATA,,}" == "y" ]]; then
    cp data/.gitkeep data/example.txt 2>/dev/null || touch data/example.txt
    echo "example,data" > data/example.txt
    echo -e "  ${GREEN}✓${NC} Example/test data added to data/"
fi

# --- Lock dependencies ---
echo ""
echo -e "${CYAN}Installing dependencies...${NC}"
git config core.longpaths true
uv lock
uv sync --dev
echo -e "  ${GREEN}✓${NC} Dependencies locked and installed"

# --- Branch protection ---

if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
    # Detect actual repo from git remote (project name may differ from repo name)
    REPO=$(git remote get-url origin 2>/dev/null | sed 's|.*github.com[:/]||;s|\.git$||')
    BP_JSON=$(mktemp)
    cat > "$BP_JSON" <<'BPEOF'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["lint", "type-check", "test (3.11)", "test (3.12)", "test (3.13)", "audit", "validate"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
BPEOF
    if gh api "repos/${REPO}/branches/main/protection" -X PUT --silent --input "$BP_JSON" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Branch protection enabled on main"
    else
        echo "  ⚠ Could not set branch protection (check gh auth permissions)"
    fi
    rm -f "$BP_JSON"

    # Enable GitHub Pages with Actions as the build source
    if gh api "repos/${REPO}/pages" -X POST -f build_type=workflow --silent 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} GitHub Pages enabled (Actions source)"
    else
        echo "  ⚠ Could not enable GitHub Pages (may already be enabled, or enable manually in Settings > Pages)"
    fi

    # Set repo description and topics
    if gh repo edit "${REPO}" --description "${DESCRIPTION}" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Repository description set"
    fi
else
    echo "  ⚠ gh CLI not found or not authenticated — set up branch protection and GitHub Pages manually"
fi

# --- Self-destruct option ---

echo ""
read -rp "Remove this setup script? It's no longer needed. (Y/n): " REMOVE_SCRIPT
if [[ "${REMOVE_SCRIPT,,}" != "n" ]]; then
    rm -f scripts/init.sh
    # Remove scripts dir if only .gitkeep remains
    rm -f scripts/.gitkeep 2>/dev/null || true
    rmdir scripts 2>/dev/null || true
    echo -e "  ${GREEN}✓${NC} Removed setup script"
fi

# --- Done ---

echo ""
echo -e "${GREEN}${BOLD}✅ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  just check        # verify everything passes"
echo "  just docs          # preview documentation"
echo "  git add -A && git commit -m 'Initial project setup'"
echo ""

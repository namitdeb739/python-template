#!/usr/bin/env bash
set -euo pipefail

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

read -rp "Project name (kebab-case, e.g. my-ml-project): " PROJECT_NAME
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: project name is required."
    exit 1
fi

# Derive Python package name (snake_case)
PACKAGE_NAME="${PROJECT_NAME//-/_}"

read -rp "Short description: " DESCRIPTION
read -rp "Author name: " AUTHOR_NAME
read -rp "Author email: " AUTHOR_EMAIL
read -rp "GitHub username or org: " GITHUB_USER

echo ""
read -rp "Initialize DVC for data versioning? (y/N): " INIT_DVC
read -rp "Create .env from .env.example? (y/N): " INIT_ENV

echo ""
echo -e "${CYAN}Setting up ${BOLD}${PROJECT_NAME}${NC}${CYAN} (package: ${PACKAGE_NAME})...${NC}"
echo ""

# --- Rename package directory ---

if [[ -d "src/project_name" && "$PACKAGE_NAME" != "project_name" ]]; then
    mv "src/project_name" "src/${PACKAGE_NAME}"
    echo -e "  ${GREEN}✓${NC} Renamed src/project_name → src/${PACKAGE_NAME}"
fi

# --- Find and replace across all files ---

find_and_replace() {
    local old="$1"
    local new="$2"
    # Use git ls-files to only touch tracked text files
    while IFS= read -r -d '' file; do
        if file --brief "$file" | grep -q text; then
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

# --- Lock dependencies ---

echo ""
echo -e "${CYAN}Installing dependencies...${NC}"
uv lock
uv sync --dev
uv run pre-commit install
echo -e "  ${GREEN}✓${NC} Dependencies locked and installed"
echo -e "  ${GREEN}✓${NC} Pre-commit hooks installed"

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

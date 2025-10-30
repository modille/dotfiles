#!/bin/bash

# Analyze project and suggest CLAUDE.md improvements
# Usage: bash scripts/analyze-claude-md.sh [project-path]

set -e

PROJECT_PATH="${1:-.}"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "Error: Project path not found: $PROJECT_PATH"
  exit 1
fi

cd "$PROJECT_PATH"

echo "{"
echo '  "project_path": "'"$(pwd)"'",'
echo '  "timestamp": "'"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"'",'

# Check if CLAUDE.md exists
if [ -f ".claude/CLAUDE.md" ]; then
  echo '  "claude_md_exists": true,'
  echo '  "claude_md_location": ".claude/CLAUDE.md",'
  echo '  "claude_md_size": '"$(wc -l <.claude/CLAUDE.md)"','
else
  echo '  "claude_md_exists": false,'
fi

# Detect package managers (supports multiple)
echo '  "detected_package_managers": ['

PACKAGE_MANAGERS=()

# Check for npm/node
if [ -f "package.json" ]; then
  PM_ENTRY='    {'
  PM_ENTRY="$PM_ENTRY"$'\n''      "type": "npm",'
  PM_ENTRY="$PM_ENTRY"$'\n''      "has_package_json": true'

  # Extract scripts
  if command -v jq &>/dev/null; then
    SCRIPTS=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | head -20)
    if [ -n "$SCRIPTS" ]; then
      PM_ENTRY="$PM_ENTRY"','$'\n''      "scripts": ['
      SCRIPT_LIST=""
      echo "$SCRIPTS" | while IFS= read -r script; do
        echo "        \"$script\","
      done | sed '$ s/,$//' >/tmp/scripts_list_$$
      SCRIPT_LIST=$(cat /tmp/scripts_list_$$)
      rm -f /tmp/scripts_list_$$
      PM_ENTRY="$PM_ENTRY"$'\n'"$SCRIPT_LIST"$'\n''      ]'
    fi
  fi

  # Detect lockfile
  if [ -f "pnpm-lock.yaml" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "lockfile": "pnpm"'
  elif [ -f "yarn.lock" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "lockfile": "yarn"'
  elif [ -f "package-lock.json" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "lockfile": "npm"'
  else
    PM_ENTRY="$PM_ENTRY"','$'\n''      "lockfile": "none"'
  fi

  PM_ENTRY="$PM_ENTRY"$'\n''    }'
  PACKAGE_MANAGERS+=("$PM_ENTRY")
fi

# Check for Cargo/Rust
if [ -f "Cargo.toml" ]; then
  PM_ENTRY='    {'$'\n''      "type": "cargo",'$'\n''      "has_cargo_toml": true'$'\n''    }'
  PACKAGE_MANAGERS+=("$PM_ENTRY")
fi

# Check for Python
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
  PM_ENTRY='    {'$'\n''      "type": "python"'
  if [ -f "pyproject.toml" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "has_pyproject": true'
  fi
  if [ -f "requirements.txt" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "has_requirements": true'
  fi
  PM_ENTRY="$PM_ENTRY"$'\n''    }'
  PACKAGE_MANAGERS+=("$PM_ENTRY")
fi

# Check for Go
if [ -f "go.mod" ]; then
  PM_ENTRY='    {'$'\n''      "type": "go",'$'\n''      "has_go_mod": true'$'\n''    }'
  PACKAGE_MANAGERS+=("$PM_ENTRY")
fi

# Check for Ruby/Bundler
if [ -f "Gemfile" ]; then
  PM_ENTRY='    {'$'\n''      "type": "bundler",'$'\n''      "has_gemfile": true'
  if [ -f "Gemfile.lock" ]; then
    PM_ENTRY="$PM_ENTRY"','$'\n''      "has_lockfile": true'
  fi
  PM_ENTRY="$PM_ENTRY"$'\n''    }'
  PACKAGE_MANAGERS+=("$PM_ENTRY")
fi

# Print package managers
if [ ${#PACKAGE_MANAGERS[@]} -eq 0 ]; then
  echo '  ],'
else
  for i in "${!PACKAGE_MANAGERS[@]}"; do
    if [ $i -eq $((${#PACKAGE_MANAGERS[@]} - 1)) ]; then
      echo "${PACKAGE_MANAGERS[$i]}"
    else
      echo "${PACKAGE_MANAGERS[$i]},"
    fi
  done
  echo '  ],'
fi

# Detect testing frameworks (supports multiple)
echo '  "testing_frameworks": ['

TEST_FRAMEWORKS=()

# Check JavaScript/TypeScript testing frameworks
if [ -f "package.json" ]; then
  if rg -q '"vitest"' package.json 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "vitest", "language": "javascript"}')
  fi
  if rg -q '"jest"' package.json 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "jest", "language": "javascript"}')
  fi
  if rg -q '"mocha"' package.json 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "mocha", "language": "javascript"}')
  fi
  if rg -q '"cypress"' package.json 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "cypress", "language": "javascript", "type": "e2e"}')
  fi
  if rg -q '"playwright"' package.json 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "playwright", "language": "javascript", "type": "e2e"}')
  fi
fi

# Check Python testing frameworks
if [ -f "pytest.ini" ] || rg -q "pytest" . 2>/dev/null; then
  TEST_FRAMEWORKS+=('    {"framework": "pytest", "language": "python"}')
fi

# Check Rust testing
if [ -f "Cargo.toml" ]; then
  TEST_FRAMEWORKS+=('    {"framework": "cargo test", "language": "rust"}')
fi

# Check Go testing
if [ -f "go.mod" ]; then
  TEST_FRAMEWORKS+=('    {"framework": "go test", "language": "go"}')
fi

# Check Ruby testing frameworks
if [ -f "Gemfile" ]; then
  if [ -d "spec" ] || rg -q "rspec" Gemfile 2>/dev/null; then
    TEST_FRAMEWORKS+=('    {"framework": "rspec", "language": "ruby"}')
  else
    TEST_FRAMEWORKS+=('    {"framework": "minitest", "language": "ruby"}')
  fi
fi

# Print testing frameworks
if [ ${#TEST_FRAMEWORKS[@]} -eq 0 ]; then
  echo '  ],'
else
  for i in "${!TEST_FRAMEWORKS[@]}"; do
    if [ $i -eq $((${#TEST_FRAMEWORKS[@]} - 1)) ]; then
      echo "${TEST_FRAMEWORKS[$i]}"
    else
      echo "${TEST_FRAMEWORKS[$i]},"
    fi
  done
  echo '  ],'
fi

# Detect frameworks (supports multiple)
echo '  "frameworks": ['

FRAMEWORKS=()

# Check JavaScript/TypeScript frameworks
if [ -f "package.json" ]; then
  # Frontend frameworks
  if rg -q '"next"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "nextjs", "language": "javascript", "category": "fullstack"}')
  fi
  if rg -q '"react"' package.json 2>/dev/null && ! rg -q '"next"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "react", "language": "javascript", "category": "frontend"}')
  fi
  if rg -q '"vue"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "vue", "language": "javascript", "category": "frontend"}')
  fi
  if rg -q '"@angular/core"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "angular", "language": "javascript", "category": "frontend"}')
  fi
  if rg -q '"svelte"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "svelte", "language": "javascript", "category": "frontend"}')
  fi

  # Backend frameworks
  if rg -q '"express"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "express", "language": "javascript", "category": "backend"}')
  fi
  if rg -q '"fastify"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "fastify", "language": "javascript", "category": "backend"}')
  fi
  if rg -q '"nestjs"' package.json 2>/dev/null || rg -q '"@nestjs/core"' package.json 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "nestjs", "language": "javascript", "category": "backend"}')
  fi
fi

# Check Rust frameworks
if [ -f "Cargo.toml" ]; then
  if rg -q "actix-web" Cargo.toml 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "actix-web", "language": "rust", "category": "backend"}')
  fi
  if rg -q "rocket" Cargo.toml 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "rocket", "language": "rust", "category": "backend"}')
  fi
  if rg -q "axum" Cargo.toml 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "axum", "language": "rust", "category": "backend"}')
  fi
fi

# Check Python frameworks
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
  if rg -q "django" . 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "django", "language": "python", "category": "fullstack"}')
  fi
  if rg -q "flask" . 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "flask", "language": "python", "category": "backend"}')
  fi
  if rg -q "fastapi" . 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "fastapi", "language": "python", "category": "backend"}')
  fi
fi

# Check Ruby frameworks
if [ -f "Gemfile" ]; then
  if [ -f "config/application.rb" ] || rg -q "rails" Gemfile 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "rails", "language": "ruby", "category": "fullstack"}')
  fi
  if rg -q "sinatra" Gemfile 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "sinatra", "language": "ruby", "category": "backend"}')
  fi
fi

# Check Go frameworks
if [ -f "go.mod" ]; then
  if rg -q "gin-gonic/gin" go.mod 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "gin", "language": "go", "category": "backend"}')
  fi
  if rg -q "labstack/echo" go.mod 2>/dev/null; then
    FRAMEWORKS+=('    {"type": "echo", "language": "go", "category": "backend"}')
  fi
fi

# Print frameworks
if [ ${#FRAMEWORKS[@]} -eq 0 ]; then
  echo '  ],'
else
  for i in "${!FRAMEWORKS[@]}"; do
    if [ $i -eq $((${#FRAMEWORKS[@]} - 1)) ]; then
      echo "${FRAMEWORKS[$i]}"
    else
      echo "${FRAMEWORKS[$i]},"
    fi
  done
  echo '  ],'
fi

# Check for common files
echo '  "project_files": {'
echo '    "has_readme": '"$([ -f "README.md" ] && echo "true" || echo "false")"','
echo '    "has_dockerfile": '"$([ -f "Dockerfile" ] && echo "true" || echo "false")"','
echo '    "has_ci": '"$([ -d ".github/workflows" ] || [ -f ".gitlab-ci.yml" ] || [ -f ".circleci/config.yml" ] && echo "true" || echo "false")"','
echo '    "has_gitignore": '"$([ -f ".gitignore" ] && echo "true" || echo "false")"','
echo '    "has_editorconfig": '"$([ -f ".editorconfig" ] && echo "true" || echo "false")"''
echo '  },'

# Directory structure
echo '  "directory_structure": {'

DIRS_TO_CHECK=("src" "lib" "app" "pages" "components" "api" "tests" "test" "__tests__" "scripts" "docs" "spec")
FOUND_DIRS=""

for dir in "${DIRS_TO_CHECK[@]}"; do
  if [ -d "$dir" ]; then
    FOUND_DIRS="$FOUND_DIRS\"$dir\", "
  fi
done

if [ -n "$FOUND_DIRS" ]; then
  echo '    "key_directories": ['"${FOUND_DIRS%, }"']'
else
  echo '    "key_directories": []'
fi

echo '  },'

# Suggest CLAUDE.md improvements
echo '  "claude_md_suggestions": ['

SUGGESTIONS=()

# Check for package.json scripts
if [ -f "package.json" ] && command -v jq &>/dev/null; then
  SCRIPTS=$(jq -r '.scripts | keys[]' package.json 2>/dev/null)
  if [ -n "$SCRIPTS" ]; then
    SUGGESTIONS+=('    "Document npm scripts (dev, build, test, lint) in CLAUDE.md"')
  fi
fi

# Check for testing
if [ -f "package.json" ]; then
  if rg -q '"vitest"' package.json 2>/dev/null || rg -q '"jest"' package.json 2>/dev/null; then
    SUGGESTIONS+=('    "Document testing approach and test commands"')
  fi
fi

# Check for TypeScript
if [ -f "tsconfig.json" ]; then
  SUGGESTIONS+=('    "Document TypeScript configuration and type checking commands"')
fi

# Check for linting
if [ -f ".eslintrc" ] || [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ]; then
  SUGGESTIONS+=('    "Document linting rules and lint commands"')
fi

# Check for Docker
if [ -f "Dockerfile" ]; then
  SUGGESTIONS+=('    "Document Docker build and run commands"')
fi

# Check for environment variables
if [ -f ".env.example" ] || [ -f ".env.local.example" ]; then
  SUGGESTIONS+=('    "Document required environment variables and setup"')
fi

# Check for monorepo
if [ -f "pnpm-workspace.yaml" ] || [ -f "lerna.json" ]; then
  SUGGESTIONS+=('    "Document monorepo structure and workspace commands"')
fi

# Check for CI/CD
if [ -d ".github/workflows" ]; then
  SUGGESTIONS+=('    "Document CI/CD workflow and deployment process"')
fi

# Check for database
if [ -f "prisma/schema.prisma" ] || rg -q "prisma" . 2>/dev/null; then
  SUGGESTIONS+=('    "Document database schema and migration commands (Prisma)"')
elif [ -d "db/migrate" ] && [ -f "Gemfile" ]; then
  SUGGESTIONS+=('    "Document database schema and migration commands (Rails/ActiveRecord)"')
elif [ -f "alembic.ini" ] || [ -d "alembic" ]; then
  SUGGESTIONS+=('    "Document database schema and migration commands (Alembic)"')
elif rg -q "sequelize" . 2>/dev/null; then
  SUGGESTIONS+=('    "Document database schema and migration commands (Sequelize)"')
elif rg -q "typeorm" . 2>/dev/null; then
  SUGGESTIONS+=('    "Document database schema and migration commands (TypeORM)"')
fi

# Print suggestions
for i in "${!SUGGESTIONS[@]}"; do
  if [ $i -eq $((${#SUGGESTIONS[@]} - 1)) ]; then
    echo "${SUGGESTIONS[$i]}"
  else
    echo "${SUGGESTIONS[$i]},"
  fi
done

echo '  ]'
echo "}"

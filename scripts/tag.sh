#!/bin/bash

# Generate semver git tags
# Usage: ./scripts/tag.sh [major|minor|patch]

set -e

BUMP_TYPE=${1:-patch}

# Get latest tag or default to v0.0.0
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

# Strip 'v' prefix and split into parts
VERSION=${LATEST_TAG#v}
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# Bump version based on type
case $BUMP_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo "Usage: $0 [major|minor|patch]"
    exit 1
    ;;
esac

NEW_VERSION="v${MAJOR}.${MINOR}.${PATCH}"

echo "Current version: $LATEST_TAG"
echo "New version:     $NEW_VERSION"
echo ""

# Confirm before tagging
read -p "Create tag $NEW_VERSION? [y/N] " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"
  echo "Tag $NEW_VERSION created."
  echo ""
  read -p "Push tag to origin? [y/N] " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push origin "$NEW_VERSION"
    echo "Tag pushed to origin."
  fi
else
  echo "Aborted."
fi

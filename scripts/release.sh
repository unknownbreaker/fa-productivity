#!/bin/bash

# Create a GitHub release with the built extension
# Usage: ./scripts/release.sh [tag]
# If no tag provided, uses the latest tag

set -e

# Get tag from argument or use latest
TAG=${1:-$(git describe --tags --abbrev=0 2>/dev/null)}

if [ -z "$TAG" ]; then
  echo "Error: No tags found. Create a tag first with: npm run tag"
  exit 1
fi

# Check if tag exists
if ! git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Error: Tag $TAG does not exist"
  exit 1
fi

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
  echo "Error: GitHub CLI (gh) is not installed"
  echo "Install it from: https://cli.github.com/"
  exit 1
fi

echo "Building extension..."
npm run build

echo "Packaging extension..."
cd dist && zip -r ../jira-ticket-page.zip . && cd ..

ZIP_FILE="jira-ticket-page.zip"

# Check if release already exists
if gh release view "$TAG" &>/dev/null; then
  echo "Release $TAG already exists."
  read -p "Update existing release? [y/N] " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Uploading asset to existing release..."
    gh release upload "$TAG" "$ZIP_FILE" --clobber
    echo "Asset uploaded to release $TAG"
  else
    echo "Aborted."
    exit 0
  fi
else
  # Push tag if not on remote
  if ! git ls-remote --tags origin | grep -q "$TAG"; then
    echo "Pushing tag $TAG to origin..."
    git push origin "$TAG"
  fi

  echo "Creating release $TAG..."

  # Get commits since previous tag for release notes
  PREV_TAG=$(git describe --tags --abbrev=0 "$TAG^" 2>/dev/null || echo "")

  if [ -n "$PREV_TAG" ]; then
    NOTES=$(git log "$PREV_TAG".."$TAG" --pretty=format:"- %s" 2>/dev/null)
  else
    NOTES=$(git log "$TAG" --pretty=format:"- %s" 2>/dev/null)
  fi

  gh release create "$TAG" "$ZIP_FILE" \
    --title "Release $TAG" \
    --notes "$NOTES"

  echo ""
  echo "Release $TAG created successfully!"
  echo "View at: $(gh release view "$TAG" --json url -q .url)"
fi

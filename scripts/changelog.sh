#!/bin/bash

# Generate/update CHANGELOG.md from git tags and commits
# Usage: ./scripts/changelog.sh

set -e

CHANGELOG_FILE="CHANGELOG.md"

# Get all tags sorted by version (newest first)
TAGS=$(git tag -l "v*" --sort=-version:refname)

if [ -z "$TAGS" ]; then
  echo "No tags found. Create a tag first with: npm run tag"
  exit 1
fi

# Start building changelog
{
  echo "# Changelog"
  echo ""
  echo "All notable changes to this project will be documented in this file."
  echo ""

  PREV_TAG=""

  for TAG in $TAGS; do
    TAG_DATE=$(git log -1 --format=%ai "$TAG" | cut -d ' ' -f 1)

    echo "## [$TAG] - $TAG_DATE"
    echo ""

    # Get commits between this tag and previous tag (or all commits if first tag)
    if [ -z "$PREV_TAG" ]; then
      # Most recent tag - get commits from this tag to HEAD if any
      UNRELEASED=$(git log "$TAG"..HEAD --oneline 2>/dev/null)
      if [ -n "$UNRELEASED" ]; then
        echo "## [Unreleased]"
        echo ""
        git log "$TAG"..HEAD --pretty=format:"- %s" 2>/dev/null
        echo ""
        echo ""
      fi
      # Get commits for this tag
      NEXT_TAG=$(echo "$TAGS" | sed -n '2p')
      if [ -n "$NEXT_TAG" ]; then
        COMMITS=$(git log "$NEXT_TAG".."$TAG" --pretty=format:"- %s" 2>/dev/null)
      else
        COMMITS=$(git log "$TAG" --pretty=format:"- %s" 2>/dev/null)
      fi
    else
      COMMITS=$(git log "$PREV_TAG".."$TAG" --pretty=format:"- %s" 2>/dev/null)
    fi

    if [ -n "$COMMITS" ]; then
      echo "$COMMITS"
    else
      echo "- Initial release"
    fi

    echo ""
    PREV_TAG=$TAG
  done

} > "$CHANGELOG_FILE"

echo "Generated $CHANGELOG_FILE"

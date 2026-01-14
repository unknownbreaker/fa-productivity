# CLAUDE.md

## Project Overview
Jira Ticket Page is a Chrome extension (Manifest V3) built with TypeScript that provides quick navigation to Jira tickets via a popup interface.

## Tech Stack
- TypeScript
- Chrome Extension Manifest V3
- No external runtime dependencies

## Project Structure
```
jira-ticket-page/
├── src/
│   ├── popup.ts          # Popup logic - handle input and navigation
│   ├── popup.html        # Popup UI - input field
│   ├── popup.css         # Popup styling
│   ├── options.ts        # Options page logic
│   ├── options.html      # Options page UI
│   └── options.css       # Options styling
├── scripts/
│   ├── tag.sh            # Semver tagging script
│   ├── changelog.sh      # Changelog generator
│   └── release.sh        # GitHub release script
├── dist/                 # Compiled output (git-ignored)
├── manifest.json         # Chrome extension manifest
├── package.json          # Node dependencies and scripts
└── tsconfig.json         # TypeScript config
```

## Build Commands
- `npm run build` - One-time build (compiles TS and copies static files to dist/)
- `npm run watch` - Watch mode for development (auto-rebuilds on .ts changes)
- `npm run package` - Creates jira-ticket-page.zip for distribution

## Release Commands
- `npm run tag` - Create a new patch version tag (default)
- `npm run tag:patch` - Bump patch version (v1.0.0 → v1.0.1)
- `npm run tag:minor` - Bump minor version (v1.0.0 → v1.1.0)
- `npm run tag:major` - Bump major version (v1.0.0 → v2.0.0)
- `npm run changelog` - Generate CHANGELOG.md from git tags and commits
- `npm run release` - Build, package, and create GitHub release with latest tag

## Development Workflow
1. Run `npm run watch` for auto-rebuilding
2. Load `dist/` folder as unpacked extension in `chrome://extensions`
3. After changes, manually reload the extension in Chrome (no auto-reload available)

## How the Extension Works
1. User clicks extension icon in toolbar
2. Popup appears with an input field (auto-focused)
3. User types/pastes a Jira ticket ID (e.g., `WEB-12345`)
4. User presses Enter
5. Extension reads the configured Jira base URL from chrome.storage.sync
6. Browser navigates to `{baseUrl}/browse/{ticketId}`

## Configuration
Users set their Jira base URL (e.g., `https://company.atlassian.net`) in the extension options page.

## Commit Convention
This project uses [Conventional Commits](https://www.conventionalcommits.org/). Format: `type: description`

| Prefix | Use for |
|--------|---------|
| `feat:` | New features |
| `fix:` | Bug fixes |
| `docs:` | Documentation changes |
| `chore:` | Maintenance, dependencies, build config |
| `refactor:` | Code changes that don't add features or fix bugs |
| `style:` | Formatting, whitespace |
| `test:` | Adding or updating tests |

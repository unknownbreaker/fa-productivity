# FA Productivity

A Chrome extension for quick navigation to Jira tickets. Click the extension icon, type a ticket ID, and go.

## Installation

### From GitHub Release
1. Download `fa-productivity.zip` from the [latest release](https://github.com/unknownbreaker/fa-productivity/releases/latest)
2. Extract to a folder
3. Open Chrome and go to `chrome://extensions`
4. Enable **Developer mode** (top right)
5. Click **Load unpacked** and select the extracted folder

### From Source
```bash
git clone git@github.com:unknownbreaker/fa-productivity.git
cd fa-productivity
npm install
npm run build
```
Then load the `dist/` folder as an unpacked extension.

## Setup

1. Right-click the extension icon → **Options**
2. Enter your Jira base URL (e.g., `https://yourcompany.atlassian.net`)
3. Click **Save**

## Usage

1. Click the extension icon in your toolbar
2. Type or paste a ticket ID (e.g., `WEB-12345`)
3. Press **Enter**
4. Browser navigates to your Jira ticket

## Development

```bash
npm run watch    # auto-rebuild on changes
```

After making changes, reload the extension in `chrome://extensions`.

### Available Scripts

| Command | Description |
|---------|-------------|
| `npm run build` | One-time build |
| `npm run watch` | Watch mode for development |
| `npm run package` | Create zip for distribution |
| `npm run tag:patch` | Bump patch version (v1.0.0 → v1.0.1) |
| `npm run tag:minor` | Bump minor version (v1.0.0 → v1.1.0) |
| `npm run tag:major` | Bump major version (v1.0.0 → v2.0.0) |
| `npm run changelog` | Generate CHANGELOG.md |
| `npm run release` | Create GitHub release |

## License

MIT

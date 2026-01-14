# SPEC.md - Project Specification & Milestones

## Goal
Provide quick navigation to Jira tickets by entering a ticket ID in a browser extension popup.

## User Flow
1. Click extension icon in toolbar
2. Paste/type ticket ID (e.g., `WEB-12345`)
3. Press Enter
4. Browser navigates to configured Jira URL + ticket ID

---

## Milestones

### Milestone 1: Core Functionality
**Status: Complete**

- [x] Project setup with TypeScript and npm
- [x] Chrome Manifest V3 configuration
- [x] Popup interface with input field
- [x] Ticket ID validation (pattern: `ABC-12345`)
- [x] Navigation to Jira ticket page
- [x] Options page for configuring Jira base URL
- [x] Build and package scripts

### Milestone 2: Enhanced UX (Future)
**Status: Not Started**

- [ ] Remember recently used ticket IDs
- [ ] Autocomplete from history
- [ ] Keyboard shortcut to open popup (e.g., `Ctrl+Shift+J`)
- [ ] Support multiple Jira instances (dropdown selector)

### Milestone 3: Power Features (Future)
**Status: Not Started**

- [ ] Omnibox integration (type `jira WEB-123` in address bar)
- [ ] Quick copy ticket link to clipboard
- [ ] Preview ticket title before navigating (API integration)
- [ ] Dark mode support

### Milestone 4: Distribution (Future)
**Status: Not Started**

- [ ] Add extension icon (16x16, 48x48, 128x128)
- [ ] Chrome Web Store listing
- [ ] Screenshots and promotional images

---

## Technical Constraints
- Must use Manifest V3 (required for new Chrome extensions)
- No external API calls in core functionality (privacy)
- Minimal permissions (only `storage` required)

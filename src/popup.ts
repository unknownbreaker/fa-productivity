// Elements - Main View
const mainView = document.getElementById('main-view') as HTMLDivElement;
const settingsBtn = document.getElementById('settings-btn') as HTMLButtonElement;
const input = document.getElementById('ticket-input') as HTMLInputElement;
const errorDiv = document.getElementById('error') as HTMLDivElement;

// Elements - Settings View
const settingsView = document.getElementById('settings-view') as HTMLDivElement;
const backBtn = document.getElementById('back-btn') as HTMLButtonElement;
const urlInput = document.getElementById('base-url') as HTMLInputElement;
const saveBtn = document.getElementById('save-btn') as HTMLButtonElement;
const statusDiv = document.getElementById('status') as HTMLDivElement;

const TICKET_PATTERN = /^[A-Z]+-\d+$/i;

// View switching
function showSettings() {
  mainView.classList.add('hidden');
  settingsView.classList.remove('hidden');
  loadSavedUrl();
}

function showMain() {
  settingsView.classList.add('hidden');
  mainView.classList.remove('hidden');
  input.focus();
}

settingsBtn.addEventListener('click', showSettings);
backBtn.addEventListener('click', showMain);

// Main view - ticket navigation
input.addEventListener('keydown', async (e) => {
  if (e.key !== 'Enter') return;

  const ticketId = input.value.trim().toUpperCase();

  if (!TICKET_PATTERN.test(ticketId)) {
    errorDiv.textContent = 'Invalid ticket format';
    return;
  }

  const result = await chrome.storage.sync.get('jiraBaseUrl');
  const baseUrl = result.jiraBaseUrl;

  if (!baseUrl) {
    errorDiv.textContent = 'Set Jira URL in settings';
    return;
  }

  const url = `${baseUrl.replace(/\/$/, '')}/browse/${ticketId}`;
  chrome.tabs.update({ url });
  window.close();
});

// Settings view - URL management
async function loadSavedUrl() {
  const result = await chrome.storage.sync.get('jiraBaseUrl');
  if (result.jiraBaseUrl) {
    urlInput.value = result.jiraBaseUrl;
  }
}

saveBtn.addEventListener('click', async () => {
  const url = urlInput.value.trim();

  if (!url) {
    statusDiv.textContent = 'Please enter a URL';
    statusDiv.className = 'error';
    return;
  }

  await chrome.storage.sync.set({ jiraBaseUrl: url });
  statusDiv.textContent = 'Saved!';
  statusDiv.className = 'success';
  setTimeout(() => {
    statusDiv.textContent = '';
    showMain();
  }, 1000);
});

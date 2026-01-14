const urlInput = document.getElementById('base-url') as HTMLInputElement;
const saveBtn = document.getElementById('save') as HTMLButtonElement;
const statusDiv = document.getElementById('status') as HTMLDivElement;

// Load saved URL
chrome.storage.sync.get('jiraBaseUrl', (result) => {
  if (result.jiraBaseUrl) {
    urlInput.value = result.jiraBaseUrl;
  }
});

saveBtn.addEventListener('click', () => {
  const url = urlInput.value.trim();

  if (!url) {
    statusDiv.textContent = 'Please enter a URL';
    statusDiv.className = 'error';
    return;
  }

  chrome.storage.sync.set({ jiraBaseUrl: url }, () => {
    statusDiv.textContent = 'Saved!';
    statusDiv.className = 'success';
    setTimeout(() => {
      statusDiv.textContent = '';
    }, 2000);
  });
});

const input = document.getElementById('ticket-input') as HTMLInputElement;
const errorDiv = document.getElementById('error') as HTMLDivElement;

const TICKET_PATTERN = /^[A-Z]+-\d+$/i;

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
    errorDiv.textContent = 'Set Jira URL in options';
    return;
  }

  const url = `${baseUrl.replace(/\/$/, '')}/browse/${ticketId}`;
  chrome.tabs.update({ url });
  window.close();
});

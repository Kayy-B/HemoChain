document.addEventListener('DOMContentLoaded', () => {
    const darkModeToggle = document.getElementById('darkModeToggle');
    const currentTheme = localStorage.getItem('theme');
    
    if (currentTheme === 'dark') {
        document.body.classList.add('dark-mode');
    }

    darkModeToggle.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
        let theme = 'light';
        if (document.body.classList.contains('dark-mode')) {
            theme = 'dark';
        }
        localStorage.setItem('theme', theme);
    });

    const connectWalletBtn = document.getElementById('connectWalletBtn');
    const accountAddress = document.getElementById('accountAddress');
    const fullAccountAddress = document.getElementById('fullAccountAddress');
    const connectDifferentAccount = document.getElementById('connectDifferentAccount');

    connectWalletBtn.addEventListener('click', async () => {
        if (window.ethereum) {
            try {
                const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
                const account = accounts[0];
                const shortAccount = `${account.slice(0, 6)}...${account.slice(-4)}`;
                accountAddress.textContent = shortAccount;
                fullAccountAddress.textContent = account;
                connectWalletBtn.style.display = 'none';
            } catch (error) {
                console.error('Error connecting to wallet:', error);
            }
        } else {
            alert('MetaMask is not installed. Please install it to use this feature.');
        }
    });

    connectDifferentAccount.addEventListener('click', async () => {
        if (window.ethereum) {
            try {
                const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
                const account = accounts[0];
                const shortAccount = `${account.slice(0, 6)}...${account.slice(-4)}`;
                accountAddress.textContent = shortAccount;
                fullAccountAddress.textContent = account;
            } catch (error) {
                console.error('Error connecting to wallet:', error);
            }
        } else {
            alert('MetaMask is not installed. Please install it to use this feature.');
        }
    });
});
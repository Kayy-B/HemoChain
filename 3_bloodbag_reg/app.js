document.addEventListener('DOMContentLoaded', async function() {
    let web3;

    // Check for MetaMask provider
    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        try {
            // Request account access
            await window.ethereum.request({ method: 'eth_requestAccounts' });
        } catch (error) {
            console.error("User denied account access");
        }
    } else if (window.web3) {
        // Legacy dApp browsers
        web3 = new Web3(window.web3.currentProvider);
    } else {
        // Non-dApp browsers
        console.error("No web3 detected. You should consider trying MetaMask.");
        // Assuming you're using Ganache
        web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
    }

    // Contract ABI and address
    const contractABI = [
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "bloodBagID",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "donorID",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "bloodBankID",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "collectionDate",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "expiryDate",
                    "type": "uint256"
                }
            ],
            "name": "BloodBagRegistered",
            "type": "event"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_donorID",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "_bloodBankID",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "_collectionDate",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "_expiryDate",
                    "type": "uint256"
                }
            ],
            "name": "registerBloodBag",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "bloodBagCount",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "bloodBags",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "donorID",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "bloodBankID",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "collectionDate",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "expiryDate",
                    "type": "uint256"
                },
                {
                    "internalType": "bool",
                    "name": "registered",
                    "type": "bool"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        }
    ];

    const contractAddress = '0x92609F3e018197528F2C3e803352C67aC6F9b338';

    // Create contract instance
    const contract = new web3.eth.Contract(contractABI, contractAddress);

    // Define registerBloodBag function
// Define a function to handle form submission
    document.getElementById('bloodBagForm').addEventListener('submit', async function(event) {
        event.preventDefault(); // Prevent the form from submitting normally

        const donorID = document.getElementById('donorID').value;
        const bloodBankID = document.getElementById('bloodBankID').value;
        const collectionDate = new Date(document.getElementById('collectionDate').value).getTime();
        const expiryDate = new Date(document.getElementById('expiryDate').value).getTime();

        try {
            // Request access to user's MetaMask accounts
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const from = accounts[0]; // Use the first account as the sender

            // Call the registerBloodBag function from the contract
            await contract.methods.registerBloodBag(donorID, bloodBankID, collectionDate, expiryDate).send({ from });

            // Display success message
            document.getElementById('message').innerHTML = "Blood bag registered successfully!";
        } catch (error) {
            console.error(error);
            // Display error message
            document.getElementById('message').innerHTML = "An error occurred. Please try again.";
        }
    });

});


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
        web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
    }

    // Contract ABI and address
    const contractABI = 
        [
            {
                "anonymous": false,
                "inputs": [
                    {
                        "indexed": false,
                        "internalType": "uint256",
                        "name": "donorID",
                        "type": "uint256"
                    },
                    {
                        "indexed": false,
                        "internalType": "string",
                        "name": "fullName",
                        "type": "string"
                    }
                ],
                "name": "DonorRegistered",
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
                        "internalType": "string",
                        "name": "_fullName",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "_mobNum",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "_emailID",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "_aadharNum",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "_residentialAddress",
                        "type": "string"
                    }
                ],
                "name": "registerDonor",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "donorCount",
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
                        "internalType": "address",
                        "name": "",
                        "type": "address"
                    }
                ],
                "name": "donorIDs",
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
                "name": "donors",
                "outputs": [
                    {
                        "internalType": "string",
                        "name": "fullName",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "mobNum",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "emailID",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "aadharNum",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "residentialAddress",
                        "type": "string"
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

    const contractAddress = '0x42c65013D17C6214d7395892B4ebF7B9d712192c';

    // Create contract instance
    const contract = new web3.eth.Contract(contractABI, contractAddress);

    // Handle form submission
    document.getElementById('donorForm').addEventListener('submit', async function(event) {
        event.preventDefault();

        const fullName = document.getElementById('fullName').value;
        const mobNum = document.getElementById('mobNum').value;
        const emailID = document.getElementById('emailID').value;
        const aadharNum = document.getElementById('aadharNum').value;
        const residentialAddress = document.getElementById('residentialAddress').value;

        try {
            // Call the registerDonor function from the contract
            const accounts = await web3.eth.getAccounts();
            await contract.methods.registerDonor(
                Math.floor(Math.random() * 1000), // Temporary donorID, replace with actual logic
                fullName,
                mobNum,
                emailID,
                aadharNum,
                residentialAddress
            ).send({ from: accounts[0] });

            // Display success message
            document.getElementById('message').innerText = 'Donor registered successfully!';
        } catch (error) {
            console.error(error);
            // Display error message
            document.getElementById('message').innerText = 'Error registering donor. Please try again.';
        }
    });
});

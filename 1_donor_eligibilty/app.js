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
    const contractABI = [
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "gender",
                    "type": "string"
                },
                {
                    "internalType": "uint256",
                    "name": "age",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "weight",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "height",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "daysSinceLastDonation",
                    "type": "uint256"
                }
            ],
            "name": "checkEligibility",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "pure",
            "type": "function"
        }
    ];

    const contractAddress = '0x2706D25aBFBe1e76cc7594cF568b63072eCB7beD';

    // Create contract instance
    const contract = new web3.eth.Contract(contractABI, contractAddress);

    // Define checkEligibility function
    window.checkEligibility = async function() {
        const gender = document.getElementById('gender').value;
        const age = document.getElementById('age').value;
        const weight = document.getElementById('weight').value;
        const height = document.getElementById('height').value;
        const lastDonation = document.getElementById('lastDonation').value;

        try {
            // Call the checkEligibility function from the contract
            const result = await contract.methods.checkEligibility(gender, age, weight, height, lastDonation).call();
            document.getElementById('result').innerText = result;
        } catch (error) {
            console.error(error);
        }
    };
});

// Define and configure web3
let web3;

if (typeof window.ethereum !== 'undefined') {
    web3 = new Web3(window.ethereum);
    try {
        // Request account access
        window.ethereum.enable();
    } catch (error) {
        console.error("User denied account access");
    }
} else if (typeof window.web3 !== 'undefined') {
    // Use the web3 object provided by legacy dApp browsers
    web3 = new Web3(window.web3.currentProvider);
} else {
    // Fallback to a local provider
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

// Define the contract ABI and address
const contractABI = [
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "uint256",
                "name": "bloodBagId",
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
                "internalType": "string",
                "name": "bloodBankName",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "string",
                "name": "status",
                "type": "string"
            }
        ],
        "name": "BloodBagFound",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "bloodBagId",
                "type": "uint256"
            },
            {
                "internalType": "enum FindBlood.Status",
                "name": "status",
                "type": "uint8"
            },
            {
                "internalType": "uint256",
                "name": "bloodBankID",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "bloodBankName",
                "type": "string"
            }
        ],
        "name": "addBloodBag",
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
                "internalType": "enum FindBlood.Status",
                "name": "status",
                "type": "uint8"
            },
            {
                "internalType": "uint256",
                "name": "bloodBankID",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "bloodBankName",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "findBlood",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
];
const contractAddress = '0xa56293c30eab96a5Cea2b98AB2fE62A4cCd6d002';

// Create contract instance
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Handle form submission
document.getElementById('getBloodStatus').addEventListener('submit', async function(event) {
    event.preventDefault(); // Prevent the form from submitting normally

    const bloodBagId = document.getElementById('getBloodBagId').value;

    try {
        // Get user's accounts
        const accounts = await web3.eth.getAccounts();
        const fromAddress = accounts[0]; // Assuming the user has at least one account

        // Call the findBlood function from the contract
        await contract.methods.findBlood().send({ from: fromAddress });

        // Listen for the BloodBagFound event
        contract.events.BloodBagFound({ filter: { bloodBagId: bloodBagId } }, function(error, event) {
            if (error) {
                console.error(error);
            } else {
                console.log(event.returnValues);
                document.getElementById('bloodStatus').innerHTML = `Blood Bag ID: ${event.returnValues.bloodBagId}<br>
                    Blood Bank ID: ${event.returnValues.bloodBankID}<br>
                    Blood Bank Name: ${event.returnValues.bloodBankName}<br>
                    Status: ${event.returnValues.status}`;
            }
        });
    } catch (error) {
        console.error(error);
        document.getElementById('bloodStatus').innerHTML = "An error occurred. Please try again.";
    }
});


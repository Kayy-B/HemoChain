// Define Web3
let web3 = new Web3(Web3.givenProvider);

// Contract ABI
let contractABI = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "enum CompatibilityMatrix.BloodType",
				"name": "",
				"type": "uint8"
			},
			{
				"internalType": "enum CompatibilityMatrix.BloodType",
				"name": "",
				"type": "uint8"
			}
		],
		"name": "compatibilityMatrix",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "enum CompatibilityMatrix.BloodType",
				"name": "_donorBloodType",
				"type": "uint8"
			},
			{
				"internalType": "enum CompatibilityMatrix.BloodType",
				"name": "_receiverBloodType",
				"type": "uint8"
			}
		],
		"name": "isCrossMatchSuccessful",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];

// Contract address
let contractAddress = '0x312712649fF6dd73fbde130978D33Cf54dc78C0B';

// Contract instance
let contract = new web3.eth.Contract(contractABI, contractAddress);

// Function to check compatibility
async function checkCompatibility() {
    // Get selected blood types from the form
    let donorBloodType = parseInt(document.getElementById('donorBloodType').value);
    let receiverBloodType = parseInt(document.getElementById('receiverBloodType').value);

    try {
        // Call the isCrossMatchSuccessful function from the contract
        let isCompatible = await contract.methods.isCrossMatchSuccessful(donorBloodType, receiverBloodType).call();

        // Display the result
        let resultElement = document.getElementById('compatibilityResult');
        resultElement.innerHTML = isCompatible ? 'Compatible' : 'Not Compatible';
    } catch (error) {
        console.error(error);
        // Display error message
        let resultElement = document.getElementById('compatibilityResult');
        resultElement.innerHTML = 'Error occurred. Please try again.';
    }
}

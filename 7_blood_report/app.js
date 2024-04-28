// Define Web3
let web3 = new Web3(Web3.givenProvider);

// Contract ABI
let contractABI = [
	{
		"inputs": [
			{
				"internalType": "int256",
				"name": "hemoglobin",
				"type": "int256"
			}
		],
		"name": "checkHemoglobin",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "int256",
				"name": "platelets",
				"type": "int256"
			}
		],
		"name": "checkPlatelets",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "int256",
				"name": "rbc",
				"type": "int256"
			}
		],
		"name": "checkRBC",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "int256",
				"name": "sugarLevel",
				"type": "int256"
			}
		],
		"name": "checkSugarLevel",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "int256",
				"name": "wbc",
				"type": "int256"
			}
		],
		"name": "checkWBC",
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

// Contract address
let contractAddress = '0xbA0E285BfF4F375AD8788C31ECa1E2f0057C61fE';

// Contract instance
let contract = new web3.eth.Contract(contractABI, contractAddress);

// Function to get results for each health parameter
async function getResults(parameter, inputId, resultId) {
    let inputValue = parseInt(document.getElementById(inputId).value);

    try {
        // Check if the method exists in the contract ABI
        let method;
        if (parameter === 'checkHemoglobin') {
            method = contract.methods.checkHemoglobin;
        } else if (parameter === 'checkPlatelets') {
            method = contract.methods.checkPlatelets;
        } else if (parameter === 'checkRBC') {
            method = contract.methods.checkRBC;
        } else if (parameter === 'checkSugarLevel') {
            method = contract.methods.checkSugarLevel;
        } else if (parameter === 'checkWBC') {
            method = contract.methods.checkWBC;
        } else {
            throw new Error(`Method ${parameter} does not exist in the contract ABI.`);
        }

        // Call the method from the contract
        let result = await method(inputValue).call();

        // Display the result
        document.getElementById(resultId).innerText = result;
    } catch (error) {
        console.error(error);
        // Display error message
        document.getElementById(resultId).innerText = 'Error occurred. Please try again.';
    }
}

// Event listener for "Get Results" buttons
document.querySelectorAll('.get-results-btn').forEach(button => {
    button.addEventListener('click', function() {
        let inputId = this.parentElement.querySelector('input').id;
        let resultId = this.parentElement.nextElementSibling.id;
        let parameter = 'check' + inputId.charAt(0).toUpperCase() + inputId.slice(1);
        getResults(parameter, inputId, resultId);
    });
});

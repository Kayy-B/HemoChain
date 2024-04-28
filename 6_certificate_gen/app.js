// Define Web3
let web3 = new Web3(Web3.givenProvider);

// Contract ABI
let contractABI = [
	{
		"inputs": [
			{
				"internalType": "enum CertificateGeneration.UserType",
				"name": "userType",
				"type": "uint8"
			},
			{
				"internalType": "string",
				"name": "donorID",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "receiverID",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "date",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "YourFullName",
				"type": "string"
			}
		],
		"name": "generateCertificate",
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
let contractAddress = '0x469848ca39040031665BE829196625582CE3b966';

// Contract instance
let contract = new web3.eth.Contract(contractABI, contractAddress);

// Function to generate certificate
async function generateCertificate() {
    // Get input values from the form
    let userType = parseInt(document.getElementById('userType').value);
    let donorID = document.getElementById('donorID').value;
    let receiverID = document.getElementById('receiverID').value;
    let date = document.getElementById('date').value;
    let fullName = document.getElementById('fullName').value;

    try {
        // Call the generateCertificate function from the contract
        let result = await contract.methods.generateCertificate(userType, donorID, receiverID, date, fullName).call();

        // Display the result
        let resultElement = document.getElementById('certificateResult');
        resultElement.innerText = result;
    } catch (error) {
        console.error(error);
        // Display error message
        let resultElement = document.getElementById('certificateResult');
        resultElement.innerText = 'Error occurred. Please try again.';
    }
}

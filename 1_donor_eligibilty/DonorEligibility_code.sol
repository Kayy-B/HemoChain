// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* Note that this contract takes input in whole numbers only
Gender input is either 'M' or 'F'
Age input is in Years
Weight input is in Kilograms
Height input is in Centimeters
Days since previous donation input is in Days */

contract DonorEligibility {
    uint constant private WEIGHT_SCALE = 100;
    uint constant private HEIGHT_SCALE = 100;

    function checkEligibility(string memory gender, uint age, uint weight, uint height, uint daysSinceLastDonation) public pure returns (string memory) {
        uint scaledWeight = weight * WEIGHT_SCALE;
        uint scaledHeight = height * HEIGHT_SCALE;

        if (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked("M"))) {
            if (age >= 17 && age <= 65 && scaledWeight >= 5896 && scaledHeight >= 15494 && daysSinceLastDonation >= 90) {
                return "Eligible";
            } else {
                string memory notMet = "";
                if (age < 17 || age > 65) {
                    notMet = "Age must be between 17 to 65 to be eligible for donation;";
                }
                if (scaledWeight < 5896) {
                    notMet = string(abi.encodePacked(notMet, " Weight must be at least 58.96kg;"));
                }
                if (scaledHeight < 15494) {
                    notMet = string(abi.encodePacked(notMet, " Height must be at least 154.94cm;"));
                }
                if (daysSinceLastDonation < 90) {
                    notMet = string(abi.encodePacked(notMet, " Minimum days since last donation must be 90 days;"));
                }
                return notMet;
            }
        } else if (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked("F"))) {
            if (age >= 19 && age <= 65 && scaledWeight >= 6803 && scaledHeight >= 16002 && daysSinceLastDonation >= 120) {
                return "Eligible";
            } else {
                string memory notMet = "";
                if (age < 19 || age > 65) {
                    notMet = "Age must be between 19 to 65 to be eligible for donation;";
                }
                if (scaledWeight < 6803) {
                    notMet = string(abi.encodePacked(notMet, " Weight must be at least 68.03kg;"));
                }
                if (scaledHeight < 16002) {
                    notMet = string(abi.encodePacked(notMet, " Height must be at least 160.02cm;"));
                }
                if (daysSinceLastDonation < 120) {
                    notMet = string(abi.encodePacked(notMet, " Minimum days since last donation must be 120 days;"));
                }
                return notMet;
            }
        } else {
            return "Invalid gender specified";
        }
    }
}

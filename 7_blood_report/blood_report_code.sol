// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthChecker {
    // Function to check if hemoglobin is within range or not (14 <= and <=18) for an adult male
    function checkHemoglobin(int256 hemoglobin) external pure returns (string memory) {
        if (hemoglobin >= 14 && hemoglobin <= 18) {
            return "inside range";
        } else {
            return "outside range";
        }
    }

    // Function to check if platelets are within range or not (150,000 <= and <=450,000) for adult males
    function checkPlatelets(int256 platelets) external pure returns (string memory) {
        if (platelets >= 150000 && platelets <= 450000) {
            return "inside range";
        } else {
            return "outside range";
        }
    }

    // Function to check if red blood cell count (rbc) is within range or not (4600000<= and <= 6000000 ie 4.6million-6million) for adult males
    function checkRBC(int256 rbc) external pure returns (string memory) {
        if (rbc >= 4600000 && rbc <= 6000000) {
            return "inside range";
        } else {
            return "outside range";
        }
    }

    // Function to check if blood sugar level is within range or not (70 <= and <= 100)
    function checkSugarLevel(int256 sugarLevel) external pure returns (string memory) {
        if (sugarLevel >= 70 && sugarLevel <= 100) {
            return "inside range";
        } else {
            return "outside range";
        }
    }

    // Function to check if white blood cell count (wbc) is within range or not (4500 <= and <= 11000)
    function checkWBC(int256 wbc) external pure returns (string memory) {
        if (wbc >= 4500 && wbc <= 11000) {
            return "inside range";
        } else {
            return "outside range";
        }
    }
}

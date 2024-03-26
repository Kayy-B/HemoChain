// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HemoglobinChecker {
    // Function to check if hemoglobin is within range or not (14 <= and <=18) for an adult male
    function check(int256 hemoglobin) external pure returns (string memory) {
        if (hemoglobin >= 14 && hemoglobin<=18) {
            return"inside range";
        } 
        else {
            return "outside range";
        }
    }
}

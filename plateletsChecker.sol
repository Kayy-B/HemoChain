// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlateletsChecker {
    // Function to check if platelets is within range or not (150,000 <= and <=450,000) for adult males
    function check(int256 platelets) external pure returns (string memory) {
        if (platelets >= 150000 && platelets<=450000) {
            return"inside range";
        } 
        else {
            return "outside range";
        }
    }
}

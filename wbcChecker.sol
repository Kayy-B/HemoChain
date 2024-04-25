// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract wbcChecker {
    // Function to check if wbc is within range or not (4500 <= and <= 11000)
    function check(int256 wbc) external pure returns (string memory) {
        if (wbc >= 4500  && wbc <= 11000) {
            return"inside range";
        } 
        else {
            return "outside range";
        }
    }
}

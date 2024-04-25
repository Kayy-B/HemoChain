// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract rbcChecker {
    // Function to check if rbc is within range or not (4600000<= and <= 6000000 ie 4.6million-6million) for adult males
    function check(int256 rbc) external pure returns (string memory) {
        if (rbc >= 4600000  && rbc <= 6000000) {
            return"inside range";
        } 
        else {
            return "outside range";
        }
    }
}

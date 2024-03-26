// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract sugarlvlChecker {
    // Function to check if blood sugar level is within range or not (70 <= and <= 100) 
    function check(int256 sugarlvl) external pure returns (string memory) {
        if (sugarlvl >= 70  && sugarlvl <= 100) {
            return"inside range";
        } 
        else {
            return "outside range";
        }
    }
}

/*Blood sugar levels can fluctuate throughout the day.
Fasting blood sugar (glucose) levels are typically considered normal if they range within 70-100 mg/dL.
Postprandial (after eating) blood sugar levels may rise temporarily but should return to normal within a few hours.*/
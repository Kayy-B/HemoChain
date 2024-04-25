// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FindBlood {
    enum Status {Unused, Used, Expired, TTI_Positive, TTI_Negative, Booked}
    
    struct BloodBag {
        Status status;
        uint256 bloodBankID;
        string bloodBankName;
    }
    
    mapping(uint256 => BloodBag) public bloodBags;
    uint256 public bloodBagCount;

    // Event to log blood bag details
    event BloodBagFound(uint256 indexed bloodBagId, uint256 bloodBankID, string bloodBankName, string status);
    
    function addBloodBag(uint256 bloodBagId, Status status, uint256 bloodBankID, string memory bloodBankName) public {
        bloodBags[bloodBagId] = BloodBag(status, bloodBankID, bloodBankName);
        bloodBagCount++;
    }

    function findBlood() public {
        for (uint256 i = 0; i < bloodBagCount; i++) {
            BloodBag storage bag = bloodBags[i];
            if (bag.status != Status.Used && bag.status != Status.Booked && bag.status != Status.Expired) {
                emit BloodBagFound(i, bag.bloodBankID, bag.bloodBankName, statusToString(bag.status));
            }
        }
    }

    // Helper function to convert Status enum to string
    function statusToString(Status _status) internal pure returns (string memory) {
        if (_status == Status.Unused) {
            return "Unused";
        } else if (_status == Status.Used) {
            return "Used";
        } else if (_status == Status.Expired) {
            return "Expired";
        } else if (_status == Status.TTI_Positive) {
            return "TTI Positive";
        } else if (_status == Status.TTI_Negative) {
            return "TTI Negative";
        } else if (_status == Status.Booked) {
            return "Booked";
        } else {
            return "Unknown";
        }
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BloodBagRegistration {
    struct BloodBag {
        uint256 donorID;
        uint256 bloodBankID;
        uint256 collectionDate;
        uint256 expiryDate;
        bool registered;
    }

    mapping(uint256 => BloodBag) public bloodBags;
    uint256 public bloodBagCount;

    event BloodBagRegistered(uint256 bloodBagID, uint256 donorID, uint256 bloodBankID, uint256 collectionDate, uint256 expiryDate);

    function registerBloodBag(
        uint256 _donorID,
        uint256 _bloodBankID,
        uint256 _collectionDate,
        uint256 _expiryDate
    ) external {
        require(_donorID > 0, "Invalid donor ID");
        require(_bloodBankID > 0, "Invalid blood bank ID");
        require(_expiryDate > _collectionDate, "Expiry date must be after collection date");

        uint256 bloodBagID = bloodBagCount + 1;

        bloodBags[bloodBagID] = BloodBag({
            donorID: _donorID,
            bloodBankID: _bloodBankID,
            collectionDate: _collectionDate,
            expiryDate: _expiryDate,
            registered: true
        });

        bloodBagCount++;

        emit BloodBagRegistered(bloodBagID, _donorID, _bloodBankID, _collectionDate, _expiryDate);
    }
}

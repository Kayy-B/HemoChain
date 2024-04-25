// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonorRegistration {
    struct Donor {
        string fullName;
        uint256 mobNum;
        string emailID;
        uint256 aadharNum;
        string residentialAddress;
        bool registered;
    }

    mapping(uint256 => Donor) public donors;
    mapping(address => uint256) public donorIDs;
    uint256 public donorCount;

    event DonorRegistered(uint256 donorID, string fullName);

    function registerDonor(
        uint256 _donorID,
        string memory _fullName,
        uint256 _mobNum,
        string memory _emailID,
        uint256 _aadharNum,
        string memory _residentialAddress
    ) external {
        require(!donorExists(_donorID), "Donor ID already exists");
        require(donorIDs[msg.sender] == 0, "Donor already registered");
        
        donors[_donorID] = Donor({
            fullName: _fullName,
            mobNum: _mobNum,
            emailID: _emailID,
            aadharNum: _aadharNum,
            residentialAddress: _residentialAddress,
            registered: true
        });

        donorIDs[msg.sender] = _donorID;
        donorCount++;

        emit DonorRegistered(_donorID, _fullName);
    }

    function donorExists(uint256 _donorID) internal view returns (bool) {
        return donors[_donorID].registered;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateGeneration {
    enum UserType { Donor, Receiver }

    function generateCertificate(
        UserType userType,
        string memory donorID,
        string memory receiverID,
        string memory date,
        string memory YourFullName
    ) public pure returns (string memory) {
        if (userType == UserType.Donor) {
            return string(
                abi.encodePacked(
                    "This is to Certify that\n",
                    YourFullName,
                    "\nof DonorID ",
                    donorID,
                    "\nhas donated blood\non ",
                    date,
                    "\n\nto ReceiverID ",
                    receiverID
                )
            );
        } else if (userType == UserType.Receiver) {
            return string(
                abi.encodePacked(
                    "This is to Certify that\n",
                    YourFullName,
                    "\nof ReceiverID ",
                    receiverID,
                    "\nhas received the Blood from\nDonorID ",
                    donorID,
                    "\non ",
                    date,
                    "."
                )
            );
        } else {
            revert("Invalid user type");
        }
    }
}

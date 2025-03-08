

// --- CompatibilityMatrix.sol ---

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CompatibilityMatrix {
    enum BloodType { O_NEGATIVE, O_POSITIVE, A_NEGATIVE, A_POSITIVE, B_NEGATIVE, B_POSITIVE, AB_NEGATIVE, AB_POSITIVE }

    mapping(BloodType => mapping(BloodType => bool)) public compatibilityMatrix;

    constructor() {
        // Initialize compatibility matrix
        
        // O- can donate to all
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.O_NEGATIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.O_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.A_NEGATIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.A_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.B_NEGATIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.B_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.AB_NEGATIVE] = true;
        compatibilityMatrix[BloodType.O_NEGATIVE][BloodType.AB_POSITIVE] = true;
        
        // O+ can donate to O+ A+ B+ AB+ (all +ve types)
        compatibilityMatrix[BloodType.O_POSITIVE][BloodType.O_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_POSITIVE][BloodType.A_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_POSITIVE][BloodType.B_POSITIVE] = true;
        compatibilityMatrix[BloodType.O_POSITIVE][BloodType.AB_POSITIVE] = true;
        
        // A- can donate to A+ A- AB+ AB-
        compatibilityMatrix[BloodType.A_NEGATIVE][BloodType.A_POSITIVE] = true;
        compatibilityMatrix[BloodType.A_NEGATIVE][BloodType.A_NEGATIVE] = true;
        compatibilityMatrix[BloodType.A_NEGATIVE][BloodType.AB_POSITIVE] = true;
        compatibilityMatrix[BloodType.A_NEGATIVE][BloodType.AB_NEGATIVE] = true;
        
        // A+ can donate to AB+ A+
        compatibilityMatrix[BloodType.A_POSITIVE][BloodType.A_POSITIVE] = true;
        compatibilityMatrix[BloodType.A_POSITIVE][BloodType.AB_POSITIVE] = true;
        
        // B- can donate to B+ B- AB+ AB-
        compatibilityMatrix[BloodType.B_NEGATIVE][BloodType.B_POSITIVE] = true;
        compatibilityMatrix[BloodType.B_NEGATIVE][BloodType.B_NEGATIVE] = true;
        compatibilityMatrix[BloodType.B_NEGATIVE][BloodType.AB_POSITIVE] = true;
        compatibilityMatrix[BloodType.B_NEGATIVE][BloodType.AB_NEGATIVE] = true;
        
        // B+ can donate to B+ AB+
        compatibilityMatrix[BloodType.B_POSITIVE][BloodType.B_POSITIVE] = true;
        compatibilityMatrix[BloodType.B_POSITIVE][BloodType.AB_POSITIVE] = true;
        
        // AB- can donate to AB+ AB-
        compatibilityMatrix[BloodType.AB_NEGATIVE][BloodType.AB_POSITIVE] = true;
        compatibilityMatrix[BloodType.AB_NEGATIVE][BloodType.AB_NEGATIVE] = true;
        
        // AB+ can donate to AB+
        compatibilityMatrix[BloodType.AB_POSITIVE][BloodType.AB_POSITIVE] = true;
    }

    function isCrossMatchSuccessful(BloodType _donorBloodType, BloodType _receiverBloodType) public view returns (bool) {
        // Check compatibility using the compatibility matrix
        return compatibilityMatrix[_donorBloodType][_receiverBloodType];
    }
}

// --- CertificateGeneration.sol ---

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

// --- DonorEligibility.sol ---

pragma solidity ^0.8.0;

/* Note that this contract takes input in whole numbers only
Gender input is either 'M' or 'F'
Age input is in Years
Weight input is in Kilograms
Height input is in Centimeters
Days since previous donation input is in Days */

contract DonorEligibility {
    uint constant private WEIGHT_SCALE = 100;
    uint constant private HEIGHT_SCALE = 100;

    function checkEligibility(string memory gender, uint age, uint weight, uint height, uint daysSinceLastDonation) public pure returns (string memory) {
        uint scaledWeight = weight * WEIGHT_SCALE;
        uint scaledHeight = height * HEIGHT_SCALE;

        if (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked("M"))) {
            if (age >= 17 && age <= 65 && scaledWeight >= 5896 && scaledHeight >= 15494 && daysSinceLastDonation >= 90) {
                return "Eligible";
            } else {
                string memory notMet = "";
                if (age < 17 || age > 65) {
                    notMet = "Age must be between 17 to 65 to be eligible for donation;";
                }
                if (scaledWeight < 5896) {
                    notMet = string(abi.encodePacked(notMet, " Weight must be at least 58.96kg;"));
                }
                if (scaledHeight < 15494) {
                    notMet = string(abi.encodePacked(notMet, " Height must be at least 154.94cm;"));
                }
                if (daysSinceLastDonation < 90) {
                    notMet = string(abi.encodePacked(notMet, " Minimum days since last donation must be 90 days;"));
                }
                return notMet;
            }
        } else if (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked("F"))) {
            if (age >= 19 && age <= 65 && scaledWeight >= 6803 && scaledHeight >= 16002 && daysSinceLastDonation >= 120) {
                return "Eligible";
            } else {
                string memory notMet = "";
                if (age < 19 || age > 65) {
                    notMet = "Age must be between 19 to 65 to be eligible for donation;";
                }
                if (scaledWeight < 6803) {
                    notMet = string(abi.encodePacked(notMet, " Weight must be at least 68.03kg;"));
                }
                if (scaledHeight < 16002) {
                    notMet = string(abi.encodePacked(notMet, " Height must be at least 160.02cm;"));
                }
                if (daysSinceLastDonation < 120) {
                    notMet = string(abi.encodePacked(notMet, " Minimum days since last donation must be 120 days;"));
                }
                return notMet;
            }
        } else {
            return "Invalid gender specified";
        }
    }
}

// --- BloodBagRegistration.sol ---

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

// --- DonorRegistration.sol ---

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

// --- BloodStatus.sol ---

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

// --- BloodReport.sol ---

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
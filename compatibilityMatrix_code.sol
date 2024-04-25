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

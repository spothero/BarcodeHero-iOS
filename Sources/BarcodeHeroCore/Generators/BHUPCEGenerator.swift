// Copyright © 2020 SpotHero, Inc. All rights reserved.

import Foundation

class BHUPCEGenerator {
    // MARK: - Properties
    
    private static let endMarker = "010101"
    private static let startMarker = "101"
    
    // Same as EAN-13 lefthand odd encodings
    private static let oddEncodings = [
        "0001101",
        "0011001",
        "0010011",
        "0111101",
        "0100011",
        "0110001",
        "0101111",
        "0111011",
        "0110111",
        "0001011",
    ]
    
    // Same as EAN-13 lefthand even encodings
    private static let evenEncodings = [
        "0100111",
        "0110011",
        "0011011",
        "0100001",
        "0011101",
        "0111001",
        "0000101",
        "0010001",
        "0001001",
        "0010111",
    ]
    
    private static let sequences = [
        "000111",
        "001011",
        "001101",
        "001110",
        "010011",
        "011001",
        "011100",
        "010101",
        "010110",
        "011010",
    ]
    
    // MARK: - Methods
    
    private func convertToUPCA(_ rawData: String) throws -> String {
        var upca = ""
        
        let code = try rawData.substring(1, length: rawData.count - 2)
        let lastDigitString = code[code.count - 1]
        
        guard let lastDigit = Int(lastDigitString) else {
            return ""
        }
        
        var insertDigits = "0000"
        
        switch lastDigit {
        case 0 ... 2:
            upca += code[0 ..< 2] + String(lastDigit) + insertDigits + code[2 ..< 5]
        case 3:
            insertDigits = "00000"
            upca += code[0 ..< 3] + String(lastDigit) + insertDigits + code[3 ..< 5]
        case 4:
            insertDigits = "00000"
            upca += code[0 ..< 4] + String(lastDigit) + insertDigits + code[4 ..< 5]
        default:
            upca += code[0 ..< 5] + String(lastDigit) + insertDigits + code[5]
        }
        
        return "00" + upca
    }
    
    private func generateCheckDigit(for rawData: String) throws -> String {
        /*
         UPC-A check digit is calculated using standard Mod10 method. Here outlines the steps to calculate UPC-A check digit:
         
         From the right to left, start with odd position, assign the odd/even position to each digit.
         Sum all digits in odd position and multiply the result by 3.
         Sum all digits in even position.
         Sum the results of step 3 and step 4.
         divide the result of step 4 by 10. The check digit is the number which adds the remainder to 10.
         If there is no remainder then the check digit equals zero.
         */
        let upca = try convertToUPCA(rawData)
        
        var oddSum = 0
        var evenSum = 0
        
        for index in 0 ..< upca.count {
            guard let digit = Int(upca[index]) else {
                continue
            }
            
            if index % 2 == 0 {
                evenSum += digit
            } else {
                oddSum += digit
            }
        }
        
        let remainder = (evenSum + oddSum * 3) % 10
        
        return String(remainder == 0 ? remainder : 10 - remainder)
    }
}

// MARK: - Extensions

extension BHUPCEGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.upce]
    }
    
    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var barcode = ""
        
        guard let checkValue = Int(rawData[rawData.count - 1]) else {
            return barcode
        }
        
        let sequence = BHUPCEGenerator.sequences[checkValue]
        
        for index in 1 ..< rawData.count - 1 {
            guard let digit = Int(rawData[index]),
                let sequenceBit = Int(sequence[index - 1]) else {
                continue
            }
            
            if sequenceBit % 2 == 0 {
                barcode += BHUPCEGenerator.evenEncodings[digit]
            } else {
                barcode += BHUPCEGenerator.oddEncodings[digit]
            }
        }
        
        return BHUPCEGenerator.startMarker + barcode + BHUPCEGenerator.endMarker
    }
    
    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard self.acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }
        
        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }
        
        guard rawData.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }
        
        guard rawData.count == 8, Int(rawData[0]) == 0 else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }
        
//            && contents[contents.length() - 1] == self.checkDigit(contents)
        
        return false
    }
}

// Copyright © 2021 SpotHero, Inc. All rights reserved.

import Foundation

class BHITFGenerator {
    // MARK: - Properties
    
    private static let characterSet = CharacterSet.decimalDigits
    private static let endMarker = "1101"
    private static let startMarker = "1010"
    
    private static let characterEncodings = [
        "00110",
        "10001",
        "01001",
        "11000",
        "00101",
        "10100",
        "01100",
        "00011",
        "10010",
        "01010",
    ]
}

// MARK: - Extensions

extension BHITFGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.itf, .itf14]
    }
    
    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var barcode = ""
        
        for index in 0 ..< rawData.count / 2 {
            let pair = try rawData.substring(index * 2, length: 2)
            
            guard let firstCharacterInPair = Int(pair[0]),
                  let secondCharacterInPair = Int(pair[1])
            else {
                continue
            }
            
            let bars = BHITFGenerator.characterEncodings[firstCharacterInPair]
            let spaces = BHITFGenerator.characterEncodings[secondCharacterInPair]
            
            for characterEncodingIndex in 0 ..< BHITFGenerator.characterEncodings.count {
                if characterEncodingIndex % 2 == 0 {
                    let bar = Int(bars[characterEncodingIndex / 2])
                    barcode += (bar == 1) ? "11" : "1"
                } else {
                    let space = Int(spaces[characterEncodingIndex / 2])
                    barcode += (space == 1) ? "00" : "0"
                }
            }
        }
        
        return BHITFGenerator.startMarker + barcode + BHITFGenerator.endMarker
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
        
//        // TODO: Allow odd encoding?
//        if rawData.count % 2 == 0 else {
//            rawData = "0\(rawData)"
//        }
        
        guard rawData.count % 2 == 0 else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }
        
        guard barcodeType == .itf || (barcodeType == .itf14 && rawData.count == 14) else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }
        
        return true
    }
}

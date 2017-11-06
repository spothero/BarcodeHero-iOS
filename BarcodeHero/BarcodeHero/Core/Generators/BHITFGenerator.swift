//
//  BHITFGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//
//  http://www.barcodeisland.com/int2of5.phtml
//  http://www.gs1au.org/assets/documents/info/user_manuals/barcode_technical_details/ITF_14_Barcode_Structure.pdf

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
        "01010"
    ]
}

// MARK: - Extensions

extension BHITFGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.itf, .itf14]
    }

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var barcode = ""

        for i in 0 ..< rawData.count / 2 {
            let pair = try rawData.substring(i * 2, length: 2)
            let bars = BHITFGenerator.characterEncodings[Int(pair[0])!]
            let spaces = BHITFGenerator.characterEncodings[Int(pair[1])!]

            for j in 0 ..< 10 {
                if j % 2 == 0 {
                    let bar = Int(bars[j / 2])
                    if bar == 1 {
                        barcode += "11"
                    } else {
                        barcode += "1"
                    }
                } else {
                    let space = Int(spaces[j / 2])
                    if space == 1 {
                        barcode += "00"
                    } else {
                        barcode += "0"
                    }
                }
            }
        }

        return BHITFGenerator.startMarker + barcode + BHITFGenerator.endMarker
    }

    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        guard rawData.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        guard rawData.count % 2 == 0 else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        guard barcodeType == .itf || (barcodeType == .itf14 && rawData.count == 14) else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        return true
    }
}

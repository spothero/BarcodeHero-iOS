//
//  BHCode39Generator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//
//  http://www.barcodesymbols.com/code39.htm
//  http://www.barcodeisland.com/code39.phtml

import Foundation

class BHCode39Generator {
    let alphabetString = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*"

    let characterEncodings = [
        "1010011011010",
        "1101001010110",
        "1011001010110",
        "1101100101010",
        "1010011010110",
        "1101001101010",
        "1011001101010",
        "1010010110110",
        "1101001011010",
        "1011001011010",
        "1101010010110",
        "1011010010110",
        "1101101001010",
        "1010110010110",
        "1101011001010",
        "1011011001010",
        "1010100110110",
        "1101010011010",
        "1011010011010",
        "1010110011010",
        "1101010100110",
        "1011010100110",
        "1101101010010",
        "1010110100110",
        "1101011010010",
        "1011011010010",
        "1010101100110",
        "1101010110010",
        "1011010110010",
        "1010110110010",
        "1100101010110",
        "1001101010110",
        "1100110101010",
        "1001011010110",
        "1100101101010",
        "1001101101010",
        "1001010110110",
        "1100101011010",
        "1001101011010",
        "1001001001010",
        "1001001010010",
        "1001010010010",
        "1010010010010",
        "1001011011010"
    ]

    func encodeCharacterString(_ characterString: String) -> String {
        let location = alphabetString.location(characterString)
        return characterEncodings[location]
    }

    func wrapData(_ barcode: String) -> String {
        return self.initiator + barcode + self.terminator
    }
}

extension BHCode39Generator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.code39]
    }

    var initiator: String {
        return self.encodeCharacterString("*")
    }

    var terminator: String {
        return self.encodeCharacterString("*")
    }

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> UIImage {
        guard try isValid(barcodeType, withData: rawData) else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        let data = try processRawData(rawData, for: barcodeType)
        let wrappedData = wrapData(data)

        guard let image = try BHBarcodeCreator.draw(wrappedData) else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return image
    }    

    func isValid(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        guard rawData.range(of: "*") == nil && rawData == rawData.uppercased() else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        for character in rawData {
            if alphabetString.location(String(character)) == NSNotFound {
                throw BHError.invalidData(rawData, for: barcodeType)
            }
        }

        return true
    }

    func processRawData(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var barcode = ""
        for character in rawData {
            barcode += self.encodeCharacterString(String(character))
        }
        return barcode
    }
}

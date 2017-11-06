//
//  BHEANGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//
//  http://blog.sina.com.cn/s/blog_4015406e0100bsqk.html

//public let RSBarcodesTypeISBN13Code = "com.pdq.rsbarcodes.isbn13"
//public let RSBarcodesTypeISSN13Code = "com.pdq.rsbarcodes.issn13"

import Foundation
import UIKit

class BHEANGenerator {
    // 'O' for odd and 'E' for even
    let lefthandParities = [
        "OOOOOO",
        "OOEOEE",
        "OOEEOE",
        "OOEEEO",
        "OEOOEE",
        "OEEOOE",
        "OEEEOO",
        "OEOEOE",
        "OEOEEO",
        "OEEOEO"
    ]

    // 'R' for right-hand
    let parityEncodingTable = [
        ["O" : "0001101", "E" : "0100111", "R" : "1110010"],
        ["O" : "0011001", "E" : "0110011", "R" : "1100110"],
        ["O" : "0010011", "E" : "0011011", "R" : "1101100"],
        ["O" : "0111101", "E" : "0100001", "R" : "1000010"],
        ["O" : "0100011", "E" : "0011101", "R" : "1011100"],
        ["O" : "0110001", "E" : "0111001", "R" : "1001110"],
        ["O" : "0101111", "E" : "0000101", "R" : "1010000"],
        ["O" : "0111011", "E" : "0010001", "R" : "1000100"],
        ["O" : "0110111", "E" : "0001001", "R" : "1001000"],
        ["O" : "0001011", "E" : "0010111", "R" : "1110100"]
    ]

    var centerGuardPattern = "01010"

    func wrapData(_ barcode: String) -> String {
        return self.initiator + barcode + self.terminator
    }
}

extension BHEANGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.ean8, .ean13, .isbn13, .issn13]
    }

    var initiator: String {
        return "101"
    }

    var terminator: String {
        return "01010"
    }

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> UIImage {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        let data = try processRawData(rawData, for: barcodeType)
        let wrappedData = wrapData(data)

        guard let image = try BHImageHelper.draw(wrappedData) else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return image
    }

    func isValid(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> Bool {
        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        for i in 0 ..< rawData.count {
            if !"0123456789".contains(rawData[i]) {
                return false
            }
        }

        guard (barcodeType == .ean8 && rawData.count == 8) || rawData.count == 13 else {
            return false
        }

        var sum_odd = 0
        var sum_even = 0

        for i in 0 ..< (rawData.count - 1) {
            guard let digit = Int(rawData[i]) else {
                continue
            }

            if i % 2 == (rawData.count == 13 ? 0 : 1) {
                sum_even += digit
            } else {
                sum_odd += digit
            }
        }

        let checkDigit = (10 - (sum_even + sum_odd * 3) % 10) % 10
        
        return Int(rawData[rawData.length() - 1]) == checkDigit
    }

    func processRawData(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var lefthandParity = "OOOO"
        var newContents = rawData

        if rawData.count == 13 {
            lefthandParity = self.lefthandParities[Int(rawData[0])!]
            newContents = rawData.substring(1, length: rawData.length() - 1)
        }

        var barcode = ""
        for i in 0..<newContents.length() {
            let digit = Int(newContents[i])!
            if i < lefthandParity.length() {
                barcode += self.parityEncodingTable[digit][lefthandParity[i]]!
                if i == lefthandParity.length() - 1 {
                    barcode += centerGuardPattern
                }
            } else {
                barcode += self.parityEncodingTable[digit]["R"]!
            }
        }
        return barcode
    }
}

//class RSEAN8Generator: RSEANGenerator {
//    init() {
//        super.init(length: 8)
//    }
//}
//
//class RSEAN13Generator: RSEANGenerator {
//    init() {
//        super.init(length: 13)
//    }
//}
//
//class RSISBN13Generator: RSEAN13Generator {
//    override func isValid(_ contents: String) -> Bool {
//        // http://www.appsbarcode.com/ISBN.php
//        return super.isValid(contents) && contents.substring(0, length: 3) == "978"
//    }
//}
//
//class RSISSN13Generator: RSEAN13Generator {
//    override func isValid(_ contents: String) -> Bool {
//        // http://www.appsbarcode.com/ISSN.php
//        return super.isValid(contents) && contents.substring(0, length: 3) == "977"
//    }
//}


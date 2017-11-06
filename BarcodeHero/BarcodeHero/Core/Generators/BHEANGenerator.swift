//
//  BHEANGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//
//  http://blog.sina.com.cn/s/blog_4015406e0100bsqk.html
//  http://www.appsbarcode.com/ISBN.php
//  http://www.appsbarcode.com/ISSN.php

//public let RSBarcodesTypeISBN13Code = "com.pdq.rsbarcodes.isbn13"
//public let RSBarcodesTypeISSN13Code = "com.pdq.rsbarcodes.issn13"

import Foundation
import UIKit

class BHEANGenerator {
    let lefthandParities = [
        "LLLLLL",
        "LLGLGG",
        "LLGGLG",
        "LLGGGL",
        "LGLLGG",
        "LGGLLG",
        "LGGGLL",
        "LGLGLG",
        "LGLGGL",
        "LGGLGL",
    ]

    let digitEncodings = [
        ["L" : "0001101", "G" : "0100111", "R" : "1110010"],
        ["L" : "0011001", "G" : "0110011", "R" : "1100110"],
        ["L" : "0010011", "G" : "0011011", "R" : "1101100"],
        ["L" : "0111101", "G" : "0100001", "R" : "1000010"],
        ["L" : "0100011", "G" : "0011101", "R" : "1011100"],
        ["L" : "0110001", "G" : "0111001", "R" : "1001110"],
        ["L" : "0101111", "G" : "0000101", "R" : "1010000"],
        ["L" : "0111011", "G" : "0010001", "R" : "1000100"],
        ["L" : "0110111", "G" : "0001001", "R" : "1001000"],
        ["L" : "0001011", "G" : "0010111", "R" : "1110100"],
    ]

    var centerMarker = "01010"
    var startMarker = "101"
    var endMarker = "01010"

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

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var lefthandParity = "LLLL"
        var encodableData = rawData

        if rawData.count == 13 {
            lefthandParity = lefthandParities[Int(rawData[0])!]

            let startIndex = rawData.index(rawData.startIndex, offsetBy: 1)
            encodableData = String(rawData[startIndex...])
        }

        var encodedData: String = ""

        for i in 0 ..< encodableData.count {
            guard let digit = Int(encodableData[i]),
                let parity = (i >= lefthandParity.count) ? "R" : lefthandParity[i],
                let encodedDigit = digitEncodings[digit][parity] else {
                    throw BHError.couldNotEncode(rawData, for: barcodeType, withResult: encodedData)
            }

            encodedData += encodedDigit

            if i == lefthandParity.count - 1 {
                encodedData += centerMarker
            }
        }

        guard encodedData.count == 8 || encodedData.count == 13 else {
            throw BHError.couldNotEncode(rawData, for: barcodeType, withResult: encodedData)
        }

        return initiator + encodedData + terminator
    }

    func isValid(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        guard rawData.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        guard barcodeType == .ean8
            || barcodeType == .ean13
            || (barcodeType == .isbn13 && rawData.starts(with: "978"))
            || (barcodeType == .issn13 && rawData.starts(with: "977")) else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        guard (barcodeType == .ean8 && rawData.count == 8) || rawData.count == 13 else {
            throw BHError.invalidData(rawData, for: barcodeType)
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
}


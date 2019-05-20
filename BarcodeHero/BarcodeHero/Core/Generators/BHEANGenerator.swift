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
    // MARK: - Properties

    private static var centerMarker = "01010"
    private static var endMarker = "01010"
    private static var startMarker = "101"

    private static let lefthandParities = [
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

    private static let digitEncodings = [
        ["L": "0001101", "G": "0100111", "R": "1110010"],
        ["L": "0011001", "G": "0110011", "R": "1100110"],
        ["L": "0010011", "G": "0011011", "R": "1101100"],
        ["L": "0111101", "G": "0100001", "R": "1000010"],
        ["L": "0100011", "G": "0011101", "R": "1011100"],
        ["L": "0110001", "G": "0111001", "R": "1001110"],
        ["L": "0101111", "G": "0000101", "R": "1010000"],
        ["L": "0111011", "G": "0010001", "R": "1000100"],
        ["L": "0110111", "G": "0001001", "R": "1001000"],
        ["L": "0001011", "G": "0010111", "R": "1110100"],
    ]
}

// MARK: - Extensions

extension BHEANGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.ean8, .ean13, .isbn13, .issn13]
    }

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var lefthandParity = "LLLL"
        var encodableData = rawData

        if rawData.count == 13 {
            if let lefthandParityIndex = Int(rawData[0]) {
                lefthandParity = BHEANGenerator.lefthandParities[lefthandParityIndex]
            }

            let startIndex = rawData.index(rawData.startIndex, offsetBy: 1)
            encodableData = String(rawData[startIndex...])
        }

        var encodedData: String = ""

        for index in 0 ..< encodableData.count {
            guard let digit = Int(encodableData[index]) else {
                throw BHError.couldNotEncode(rawData, for: barcodeType, withResult: encodedData)
            }

            let parity = (index >= lefthandParity.count) ? "R" : lefthandParity[index]

            guard let encodedDigit = BHEANGenerator.digitEncodings[digit][parity] else {
                throw BHError.couldNotEncode(rawData, for: barcodeType, withResult: encodedData)
            }

            encodedData += encodedDigit

            if index == lefthandParity.count - 1 {
                encodedData += BHEANGenerator.centerMarker
            }
        }

        return BHEANGenerator.startMarker + encodedData + BHEANGenerator.endMarker
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

        guard barcodeType == .ean8
            || barcodeType == .ean13
            || (barcodeType == .isbn13 && rawData.starts(with: "978"))
            || (barcodeType == .issn13 && rawData.starts(with: "977")) else {
                throw BHError.invalidData(rawData, for: barcodeType)
        }

        guard (barcodeType == .ean8 && rawData.count == 8) || rawData.count == 13 else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        var sumOdd = 0
        var sumEven = 0

        for index in 0 ..< (rawData.count - 1) {
            guard let digit = Int(rawData[index]) else {
                continue
            }

            if index % 2 == (rawData.count == 13 ? 0 : 1) {
                sumEven += digit
            } else {
                sumOdd += digit
            }
        }

        let checkDigit = (10 - (sumEven + sumOdd * 3) % 10) % 10

        return Int(rawData[rawData.count - 1]) == checkDigit
    }
}

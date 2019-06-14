//
//  BHCode93Generator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

class BHCode93Generator {
    // MARK: - Properties

    private static let acceptedCharacterCount = 48
    private static let acceptedCharacters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%"
    private static let characterSet = CharacterSet(charactersIn: acceptedCharacters)
    private static let endMarker = "*"
    private static let startMarker: String = "*"

    private static let characterEncodings = [
        "0": "100010100",
        "1": "101001000",
        "2": "101000100",
        "3": "101000010",
        "4": "100101000",
        "5": "100100100",
        "6": "100100010",
        "7": "101010000",
        "8": "100010010",
        "9": "100001010",
        "A": "110101000",
        "B": "110100100",
        "C": "110100010",
        "D": "110010100",
        "E": "110010010",
        "F": "110001010",
        "G": "101101000",
        "H": "101100100",
        "I": "101100010",
        "J": "100110100",
        "K": "100011010",
        "L": "101011000",
        "M": "101001100",
        "N": "101000110",
        "O": "100101100",
        "P": "100010110",
        "Q": "110110100",
        "R": "110110010",
        "S": "110101100",
        "T": "110100110",
        "U": "110010110",
        "V": "110011010",
        "W": "101101100",
        "X": "101100110",
        "Y": "100110110",
        "Z": "100111010",
        "-": "100101110",
        ".": "111010100",
        " ": "111010010",
        "$": "111001010",
        "/": "101101110",
        "+": "101110110",
        "%": "110101110",
        // "($)": "100100110",
        // "(/)": "111011010",
        // "(+)": "111010110",
        // "(%)": "100110010",
        "*": "101011110",
    ]

    // MARK: - Methods

    private func encode(character: Character) throws -> String {
        guard let encodedCharacter = BHCode93Generator.characterEncodings[String(character)] else {
            throw BHError.characterEncodingNotFound(String(character))
        }

        return encodedCharacter
    }

    private func generateCheckDigits(for rawData: String) throws -> String {
        // Weighted sum += value * weight

        // The first character
        var sum = 0

        for index in 0 ..< rawData.count {
            let character = rawData[rawData.count - index - 1]
            let indexDistance = try BHCode93Generator.acceptedCharacters.indexDistance(of: character)

            sum += indexDistance * (index % 20 + 1)
        }

        var checkDigits = ""

        checkDigits += BHCode93Generator.acceptedCharacters[sum % (BHCode93Generator.acceptedCharacterCount - 1)]

        // The second character
        sum = 0

        let newContents = rawData + checkDigits

        for newContentsIndex in 0 ..< newContents.count {
            let character = newContents[newContents.count - newContentsIndex - 1]

            let index = try BHCode93Generator.acceptedCharacters.indexDistance(of: character)

            sum += index * (newContentsIndex % 15 + 1)
        }

        checkDigits += BHCode93Generator.acceptedCharacters[sum % (BHCode93Generator.acceptedCharacterCount - 1)]

        return checkDigits
    }
}

// MARK: - Extensions

extension BHCode93Generator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.code93]
    }

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var rawData = try rawData + self.generateCheckDigits(for: rawData)

        rawData = BHCode93Generator.startMarker + rawData + BHCode93Generator.endMarker

        return try rawData.map { try encode(character: $0) }.joined()
    }

    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard self.acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        guard rawData.rangeOfCharacter(from: BHCode93Generator.characterSet.inverted) == nil else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        return true
    }
}

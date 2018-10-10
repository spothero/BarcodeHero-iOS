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
    // MARK: - Properties

    private static let acceptedCharacters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%"
    private static let characterSet = CharacterSet(charactersIn: acceptedCharacters)
    private static let endMarker = "*"
    private static let startMarker: String = "*"

    private static let characterEncodings = [
        "0": "1010011011010",
        "1": "1101001010110",
        "2": "1011001010110",
        "3": "1101100101010",
        "4": "1010011010110",
        "5": "1101001101010",
        "6": "1011001101010",
        "7": "1010010110110",
        "8": "1101001011010",
        "9": "1011001011010",
        "A": "1101010010110",
        "B": "1011010010110",
        "C": "1101101001010",
        "D": "1010110010110",
        "E": "1101011001010",
        "F": "1011011001010",
        "G": "1010100110110",
        "H": "1101010011010",
        "I": "1011010011010",
        "J": "1010110011010",
        "K": "1101010100110",
        "L": "1011010100110",
        "M": "1101101010010",
        "N": "1010110100110",
        "O": "1101011010010",
        "P": "1011011010010",
        "Q": "1010101100110",
        "R": "1101010110010",
        "S": "1011010110010",
        "T": "1010110110010",
        "U": "1100101010110",
        "V": "1001101010110",
        "W": "1100110101010",
        "X": "1001011010110",
        "Y": "1100101101010",
        "Z": "1001101101010",
        "-": "1001010110110",
        ".": "1100101011010",
        " ": "1001101011010",
        "$": "1001001001010",
        "/": "1001001010010",
        "+": "1001010010010",
        "%": "1010010010010",
        "*": "1001011011010",
    ]

    // MARK: - Methods

    private func encode(character: Character) throws -> String {
        guard let encodedCharacter = BHCode39Generator.characterEncodings[String(character)] else {
            throw BHError.characterEncodingNotFound(String(character))
        }

        return encodedCharacter
    }

    private func generateCheckDigit(for rawData: String) throws -> String {
        /**
         Step 1: From the table below, find the values of each character.
         C    O    D    E        3    9    <--Message characters
         12   24   13   14  38   3    9    <--Character values

         Step 2: Sum the character values.
         12 + 24 + 13 + 14 + 38 + 3 + 9 = 113

         Step 3: Divide the result by 43.
         113 / 43 = 11  with remainder of 27.

         Step 4: From the table, find the character with this value.
         27 = R = Check Character
         */
        var sum = 0

        for character in rawData {
            let index = try BHCode39Generator.acceptedCharacters.indexDistance(of: character)

            sum += index
        }

        // 43 = CODE39_ALPHABET_STRING's length - 1 -- excludes asterisk
        return BHCode39Generator.acceptedCharacters[sum % (BHCode39Generator.acceptedCharacters.count - 1)]
    }
}

// MARK: - Extensions

extension BHCode39Generator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] {
        return [.code39, .code39Mod43]
    }

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        var rawData = rawData

        if barcodeType == .code39Mod43 {
            rawData += try generateCheckDigit(for: rawData)
        }

        rawData = BHCode39Generator.startMarker + rawData + BHCode39Generator.endMarker

        return try rawData.map { try encode(character: $0) }.joined()
    }

    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        guard rawData.rangeOfCharacter(from: BHCode39Generator.characterSet.inverted) == nil else {
            throw BHError.invalidData(rawData, for: barcodeType)
        }

        return true
    }
}

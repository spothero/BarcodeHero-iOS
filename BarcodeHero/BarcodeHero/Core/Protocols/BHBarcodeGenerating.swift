//
//  BHBarcodeGenerating.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

protocol BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] { get }
    var initiator: String { get }
    var terminator: String { get }

    func generate(_ barcodeType: BHBarcodeType?, withData rawData: String?) throws -> UIImage
    func generate(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> UIImage

    func isValid(_ barcodeType: BHBarcodeType?, withData rawData: String?) throws -> Bool
    func isValid(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> Bool

    func processRawData(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String
//    func validate(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool
}

extension BHBarcodeGenerating {
    var initiator: String {
        return ""
    }

    var terminator: String {
        return ""
    }

    func generate(_ barcodeType: BHBarcodeType?, withData rawData: String?) throws -> UIImage {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }

        guard let rawData = rawData else {
            throw BHError.dataRequired
        }

        return try generate(barcodeType, withData: rawData)
    }

    func isValid(_ barcodeType: BHBarcodeType?, withData rawData: String?) throws -> Bool {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }

        guard let rawData = rawData else {
            throw BHError.dataRequired
        }

        return try isValid(barcodeType, withData: rawData)
    }

//    func validate(_ rawData: String, for barcodeType: BHBarcodeType) throws {
//        try isValid(rawData, for: barcodeType)
//    }
}

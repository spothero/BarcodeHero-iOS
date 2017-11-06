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

    func isValid(_ rawData: String?, for barcodeType: BHBarcodeType?) throws -> Bool
    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool

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

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> UIImage {
        try validate(rawData, for: barcodeType)
//        guard try isValid(barcodeType, withData: rawData) else {
//            throw BHError.invalidData(rawData, for: barcodeType)
//        }

        let data = try processRawData(rawData, for: barcodeType)

        guard let image = try BHImageHelper.draw(data) else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return image
    }

    func isValid(_ rawData: String?, for barcodeType: BHBarcodeType?) throws -> Bool {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }

        guard let rawData = rawData else {
            throw BHError.dataRequired
        }

        return try isValid(rawData, for: barcodeType)
    }

    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        return true
    }

    func processRawData(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        return rawData
    }

    func validate(_ rawData: String, for barcodeType: BHBarcodeType) throws {
        try isValid(rawData, for: barcodeType)
    }
}

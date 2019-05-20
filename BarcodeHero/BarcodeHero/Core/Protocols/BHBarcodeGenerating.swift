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

    func encode(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String
    func generate(_ barcodeType: BHBarcodeType, withData rawData: String, options: BHBarcodeOptions?) throws -> UIImage
    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool
}

extension BHBarcodeGenerating {
    func encode(_ rawData: String, for _: BHBarcodeType) throws -> String {
        return rawData
    }

//    func generate(_ barcodeType: BHBarcodeType?, withData rawData: String?, options: BHBarcodeOptions? = nil) throws -> UIImage {
//        guard let barcodeType = barcodeType else {
//            throw BHError.typeRequired
//        }
//
//        guard let rawData = rawData else {
//            throw BHError.dataRequired
//        }
//
//        return try generate(barcodeType, withData: rawData, options: options)
//    }

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String, options: BHBarcodeOptions? = nil) throws -> UIImage {
        try self.validate(rawData, for: barcodeType)
//        guard try isValid(barcodeType, withData: rawData) else {
//            throw BHError.invalidData(rawData, for: barcodeType)
//        }

        let data = try encode(rawData, for: barcodeType)

        guard let image = try BHImageHelper.draw(data, options: options) else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return image
    }

//    @discardableResult
//    func isValid(_ rawData: String?, for barcodeType: BHBarcodeType?) throws -> Bool {
//        guard let barcodeType = barcodeType else {
//            throw BHError.typeRequired
//        }
//
//        guard let rawData = rawData else {
//            throw BHError.dataRequired
//        }
//
//        return try isValid(rawData, for: barcodeType)
//    }

    @discardableResult
    func isValid(_ rawData: String, for barcodeType: BHBarcodeType) throws -> Bool {
        guard acceptedTypes.contains(barcodeType) else {
            throw BHError.invalidType(barcodeType)
        }

        guard !rawData.isEmpty else {
            throw BHError.dataRequired
        }

        return true
    }

    func validate(_ rawData: String, for barcodeType: BHBarcodeType) throws {
        _ = try self.isValid(rawData, for: barcodeType)
    }
}

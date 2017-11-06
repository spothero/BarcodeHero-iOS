//
//  BHBarcodeGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

public class BHBarcodeGenerator {
    public class func generate(_ barcodeType: BHBarcodeType?, withData data: String?) throws -> UIImage {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }

        guard let data = data else {
            throw BHError.dataRequired
        }

        guard let generator = try getGenerator(for: barcodeType) else {
            throw BHError.couldNotGetGenerator(barcodeType)
        }

        return try generator.generate(barcodeType, withData: data)
    }

    private static func getGenerator(for barcodeType: BHBarcodeType?) throws -> BHBarcodeGenerating? {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }

        switch barcodeType {
        case .aztec, .code128, .pdf417, .qr:
            return BHNativeBarcodeGenerator()
        case .code39, .code39Mod43:
            return BHCode39Generator()
        case .ean8, .ean13, .isbn13, .issn13:
            return BHEANGenerator()
        case .itf, .itf14:
            return BHITFGenerator()
        case .dataMatrix:
            return nil
        case .code93:
            return nil
        case .extendedCode39:
            return nil
        case .upce:
            return nil
        }
    }
}

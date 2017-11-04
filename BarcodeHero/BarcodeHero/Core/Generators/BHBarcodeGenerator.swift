//
//  BHBarcodeGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

public class BHBarcodeGenerator {
    public static func generate(type: BHBarcodeType?, text: String?) -> CIImage? {
        guard let type = type, let text = text else {
            return nil
        }

        let generator = BHCodeGeneratorType(barcodeType: type)
        let data = text.data(using: .isoLatin1, allowLossyConversion: false)

        guard let filter = CIFilter(name: generator.rawValue) else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        switch type {
        case .aztec:
//            filter.setValue(0, forKey: BHAztecParameters.inputCompactStyle.rawValue)
//            filter.setValue(23, forKey: BHAztecParameters.inputCorrectionLevel.rawValue)
//            filter.setValue(0, forKey: BHAztecParameters.inputLayers.rawValue)
            break
        case .code128:
            break
        case .pdf417:
            break
        case .qr:
            filter.setValue(BHQRInputCorrectionLevel.medium.rawValue, forKey: BHQRParameters.inputCorrectionLevel.rawValue)
        }

        return filter.outputImage
    }
}

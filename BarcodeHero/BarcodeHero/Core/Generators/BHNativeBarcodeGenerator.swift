//
//  BHNativeBarcodeGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import CoreImage
import Foundation
import UIKit

class BHNativeBarcodeGenerator: BHBarcodeGenerating {
    // MARK: - Properties

    var acceptedTypes: [BHBarcodeType] = [.aztec, .code128, .pdf417, .qr]

    // MARK: - Methods

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String, options: BHBarcodeOptions? = nil) throws -> UIImage {
        try validate(rawData, for: barcodeType)

        let data = rawData.data(using: .isoLatin1, allowLossyConversion: false)

        guard let generator = try BHNativeCodeGeneratorType(barcodeType: barcodeType) else {
            throw BHError.couldNotGetGenerator(barcodeType)
        }

        let context = CIContext(options: nil)

        guard let filter = CIFilter(name: generator.rawValue) else {
            throw BHError.couldNotCreateFilter(barcodeType)
        }

        filter.setValue(data, forKey: BHFilterParameterKey.inputMessage.rawValue)

        if let filterParameters = options?.filterParameters {
            filterParameters.loadInto(filter)
//            for parameter in filterParameters {
//                filter.setValue(parameter.value, forKey: parameter.key)
//            }
        }

//        switch barcodeType {
//        case .aztec:
//            //            filter.setValue(0, forKey: BHAztecParameters.inputCompactStyle.rawValue)
//            //            filter.setValue(23, forKey: BHAztecParameters.inputCorrectionLevel.rawValue)
//            //            filter.setValue(0, forKey: BHAztecParameters.inputLayers.rawValue)
//            break
//        case .code128:
//            break
//        case .pdf417:
//            break
//        case .qr:
//            filter.setValue(BHQRInputCorrectionLevel.medium.rawValue, forKey: BHQRParameters.inputCorrectionLevel.rawValue)
//        default:
//            throw BHError.nonNativeType(barcodeType)
//        }

        guard let filterImage = filter.outputImage,
            let cgImage = context.createCGImage(filterImage, from: filterImage.extent) else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return UIImage(cgImage: cgImage)

        // Keeping the following block around (and commented) just in case
        //        guard let outputImage = filter.outputImage,
        //            let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent) else {
        //                return nil
        //        }
        //
        //        return UIImage(cgImage: cgImage, scale: 1, orientation: UIImageOrientation.up)
    }
}

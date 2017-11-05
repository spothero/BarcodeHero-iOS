//
//  BHNativeBarcodeGenerator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

class BHNativeBarcodeGenerator: BHBarcodeGenerating {
    var acceptedTypes: [BHBarcodeType] = [.aztec, .code128, .pdf417, .qr]

    func generate(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> UIImage {
        let data = rawData.data(using: .isoLatin1, allowLossyConversion: false)

        guard barcodeType.isNative == true else {
            throw BHError.nonNativeType(barcodeType)
        }

        guard let generator = BHNativeCodeGeneratorType(barcodeType: barcodeType) else {
            throw BHError.nonNativeType(barcodeType)
        }

        guard let filter = CIFilter(name: generator.rawValue) else {
            throw BHError.couldNotCreateFilter(barcodeType)
        }

        filter.setValue(data, forKey: "inputMessage")

        switch barcodeType {
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
        default:
            throw BHError.nonNativeType(barcodeType)
        }

        guard let image = filter.outputImage?.uiImage else {
            throw BHError.couldNotCreateImage(barcodeType)
        }

        return image

        // Keeping the following block around (and commented) just in case
        //        guard let outputImage = filter.outputImage,
        //            let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent) else {
        //                return nil
        //        }
        //
        //        return UIImage(cgImage: cgImage, scale: 1, orientation: UIImageOrientation.up)
    }

    func isValid(_ barcodeType: BHBarcodeType, withData rawData: String) throws -> Bool {
        return true
    }

    func processRawData(_ rawData: String, for barcodeType: BHBarcodeType) throws -> String {
        return ""
    }
}

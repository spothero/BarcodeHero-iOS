// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreGraphics
    import CoreImage
    import Foundation
    
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    class BHNativeBarcodeGenerator: BHBarcodeGenerating {
        // MARK: - Properties
        
        var acceptedTypes: [BHBarcodeType] = [.aztec, .code128, .pdf417, .qr]
        
        // MARK: - Methods
        
        func generate(_ barcodeType: BHBarcodeType, withData rawData: String, options: BHBarcodeOptions? = nil) throws -> CGImage {
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
            } else if barcodeType == .code128 {
                // TODO: We are replacing the native quiet zone here, figure out a better way to load defaults
                BHCode128FilterParameters().loadInto(filter)
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
            
            var filterImage: CIImage?
            
            if
                let fillColor = options?.fillColor,
                let strokeColor = options?.strokeColor {
                // Create a color filter to pass the image through
                let colorFilter = CIFilter(name: "CIFalseColor")
                colorFilter?.setValue(filter.outputImage, forKey: BHColorFilterParameterKey.inputImage.rawValue)
                colorFilter?.setValue(CIColor(cgColor: fillColor), forKey: BHColorFilterParameterKey.backgroundColor.rawValue)
                colorFilter?.setValue(CIColor(cgColor: strokeColor), forKey: BHColorFilterParameterKey.foregroundColor.rawValue)
                
                filterImage = colorFilter?.outputImage
            } else {
                filterImage = filter.outputImage
            }
            
            guard
                let ciImage = filterImage,
                let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                throw BHError.couldNotCreateImage(barcodeType)
            }
            
            return cgImage
            
            // Keeping the following block around (and commented) just in case
            //        guard let outputImage = filter.outputImage,
            //            let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent) else {
            //                return nil
            //        }
            //
            //        return UIImage(cgImage: cgImage, scale: 1, orientation: UIImageOrientation.up)
        }
    }
    
#endif

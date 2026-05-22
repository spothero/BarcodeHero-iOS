// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreGraphics
    import CoreImage
    import Foundation
    
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    class BHNativeBarcodeGenerator: BHBarcodeGenerating {
        private static let context = CIContext(options: nil)

        // MARK: - Properties
        
        var acceptedTypes: [BHBarcodeType] = [.aztec, .code128, .pdf417, .qr]
        
        // MARK: - Methods
        
        func generate(_ barcodeType: BHBarcodeType, withData rawData: String, options: BHBarcodeOptions? = nil) throws -> CGImage {
            try validate(rawData, for: barcodeType)
            
            let data = rawData.data(using: .isoLatin1, allowLossyConversion: false)
            
            guard let generator = try BHNativeCodeGeneratorType(barcodeType: barcodeType) else {
                throw BHError.couldNotGetGenerator(barcodeType)
            }

            guard let filter = CIFilter(name: generator.rawValue) else {
                throw BHError.couldNotCreateFilter(barcodeType)
            }
            
            filter.setValue(data, forKey: BHFilterParameterKey.inputMessage.rawValue)
            
            if let filterParameters = options?.filterParameters {
                filterParameters.loadInto(filter)
            } else if barcodeType == .code128 {
                // TODO: We are replacing the native quiet zone here, figure out a better way to load defaults
                BHCode128FilterParameters().loadInto(filter)
            }

            if barcodeType == .qr {
                let level = (options?.qrCorrectionLevel ?? .low).rawValue
                filter.setValue(level, forKey: BHQRFilterParameterKey.inputCorrectionLevel.rawValue)
            }
            
            let filterImage: CIImage?
            if let fillColor = options?.fillColor, let strokeColor = options?.strokeColor {
                // Create a color filter to pass the image through
                let colorFilter = CIFilter(name: "CIFalseColor")
                colorFilter?.setValue(filter.outputImage, forKey: BHColorFilterParameterKey.inputImage.rawValue)
                colorFilter?.setValue(CIColor(cgColor: fillColor), forKey: BHColorFilterParameterKey.backgroundColor.rawValue)
                colorFilter?.setValue(CIColor(cgColor: strokeColor), forKey: BHColorFilterParameterKey.foregroundColor.rawValue)
                
                filterImage = colorFilter?.outputImage
            } else {
                filterImage = filter.outputImage
            }
            
            guard let ciImage = filterImage, let cgImage = Self.context.createCGImage(ciImage, from: ciImage.extent) else {
                throw BHError.couldNotCreateImage(barcodeType)
            }
            
            return cgImage
        }
    }
    
#endif

// Copyright © 2021 SpotHero, Inc. All rights reserved.

import AVFoundation
import CoreGraphics
import Foundation

public class BHBarcodeGenerator {
    public class func generate(_ barcodeType: BHBarcodeType?, withData data: String?, options: BHBarcodeOptions? = nil) throws -> CGImage {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }
        
        guard let data = data else {
            throw BHError.dataRequired
        }
        
        guard let generator = try getGenerator(for: barcodeType) else {
            throw BHError.couldNotGetGenerator(barcodeType)
        }
        
        return try generator.generate(barcodeType, withData: data, options: options)
    }
    
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public class func generate(_ metadataObjectType: AVMetadataObject.ObjectType?,
                               withData data: String?,
                               options: BHBarcodeOptions? = nil) throws -> CGImage
    {
        guard let metadataObjectType = metadataObjectType else {
            throw BHError.metadataObjectTypeRequired
        }
        
        guard let barcodeType = BHBarcodeType(metadataObjectType: metadataObjectType) else {
            throw BHError.invalidMetadataObjectType(metadataObjectType.rawValue)
        }
        
        return try self.generate(barcodeType, withData: data, options: options)
    }
    
    private static func getGenerator(for barcodeType: BHBarcodeType?) throws -> BHBarcodeGenerating? {
        guard let barcodeType = barcodeType else {
            throw BHError.typeRequired
        }
        
        switch barcodeType {
        case .aztec, .code128, .pdf417, .qr:
            #if os(tvOS) || os(watchOS)
                return nil
            #else
                return BHNativeBarcodeGenerator()
            #endif
        case .code39, .code39Mod43:
            return BHCode39Generator()
        case .ean8, .ean13, .isbn13, .issn13:
            return BHEANGenerator()
        case .itf, .itf14:
            return BHITFGenerator()
        case .code93:
            return BHCode93Generator()
        case .upce:
            return BHUPCEGenerator()
        }
    }
}

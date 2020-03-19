// Copyright © 2019 SpotHero, Inc. All rights reserved.

import AVFoundation
import Foundation

public enum BHError: Error {
//    case generic(String)
    case characterEncodingNotFound(String)
    case couldNotCreateFilter(BHBarcodeType)
    case couldNotCreateImage(BHBarcodeType)
    case couldNotCreateImageFromContext
    case couldNotEncode(String, for: BHBarcodeType, withResult: String)
    case couldNotGetGenerator(BHBarcodeType)
    case couldNotGetGraphicsContext
    case dataRequired
    case indexOutOfBounds
    case invalidData(String, for: BHBarcodeType)
    case invalidMetadataObjectType(String)
    case invalidType(BHBarcodeType)
    case metadataObjectTypeRequired
    case nonNativeType(BHBarcodeType)
    case typeRequired
//    case unknown
    
}

extension BHError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .characterEncodingNotFound(character):
            return "Character encoding not found for character '\(character)'."
        case let .couldNotCreateFilter(barcodeType):
            return "Could not create filter for barcode type '\(barcodeType)'."
        case let .couldNotCreateImage(barcodeType):
            return "Could not create image for barcode type '\(barcodeType)'."
        case .couldNotCreateImageFromContext:
            return "Could not create image from graphics context."
        case let .couldNotEncode(rawData, barcodeType, encodedData):
            return "Could not encode '\(rawData)' for barcode type '\(barcodeType)'. Result: '\(encodedData)'."
        case let .couldNotGetGenerator(barcodeType):
            return "Could not get generator for barcode type '\(barcodeType)'."
        case .couldNotGetGraphicsContext:
            return "Coulde not get current graphics context."
        case .dataRequired:
            return "Data is required for barcode generation."
//        case .generic(let message):
//            return message
        case .indexOutOfBounds:
            return "Index is out of bounds."
        case let .invalidData(data, barcodeType):
            return "Data '\(data)' is invalid for barcode type '\(barcodeType.rawValue)'."
        case let .invalidMetadataObjectType(metadataObjectType):
            return "Metadata object type '\(metadataObjectType)' is invalid."
        case let .invalidType(barcodeType):
            return "Barcode type '\(barcodeType.rawValue)' is invalid."
        case .metadataObjectTypeRequired:
            return "Metadata object type is required for barcode generation."
        case let .nonNativeType(barcodeType):
            return "'\(barcodeType.rawValue)' is not a native barcode type."
        case .typeRequired:
            return "Type is required for barcode generation."
//        case .unknown:
//            return "An unknown error has occurred."
        }
    }

    public var failureReason: String? {
        return nil
    }

    public var recoverySuggestion: String? {
        return nil
    }
}

//
//  BHError.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import Foundation

public enum BHError: Error {
//    case generic(String)
    case characterEncodingNotFound(String)
    case couldNotCreateFilter(BHBarcodeType)
    case couldNotCreateImage(BHBarcodeType)
    case couldNotEncode(String, for: BHBarcodeType, withResult: String)
    case couldNotGetGenerator(BHBarcodeType)
    case couldNotGetGraphicsContext
    case dataRequired
    case imageViewRequired
    case indexOutOfBounds
    case invalidData(String, for: BHBarcodeType)
    case invalidMetadataObjectType(AVMetadataObject.ObjectType)
    case invalidType(BHBarcodeType)
    case metadataObjectTypeRequired
    case nonNativeType(BHBarcodeType)
    case sizeRequired
    case typeRequired
//    case unknown
}

extension BHError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .characterEncodingNotFound(let character):
            return "Character encoding not found for character '\(character)'."
        case .couldNotCreateFilter(let barcodeType):
            return "Could not create filter for barcode type '\(barcodeType)'."
        case .couldNotCreateImage(let barcodeType):
            return "Could not create image for barcode type '\(barcodeType)'."
        case .couldNotEncode(let rawData, let barcodeType, let encodedData):
            return "Could not encode '\(rawData)' for barcode type '\(barcodeType)'. Result: '\(encodedData)'."
        case .couldNotGetGenerator(let barcodeType):
            return "Could not get generator for barcode type '\(barcodeType)'."
        case .couldNotGetGraphicsContext:
            return "Coulde not get current graphics context."
        case .dataRequired:
            return "Data is required for barcode generation."
//        case .generic(let message):
//            return message
        case .imageViewRequired:
            return "Image view is required for barcode resizing."
        case .indexOutOfBounds:
            return "Index is out of bounds."
        case .invalidData(let data, let barcodeType):
            return "Data '\(data)' is invalid for barcode type '\(barcodeType.rawValue)'."
        case .invalidMetadataObjectType(let metadataObjectType):
            return "Metadata object type '\(metadataObjectType.rawValue)' is invalid."
        case .invalidType(let barcodeType):
            return "Barcode type '\(barcodeType.rawValue)' is invalid."
        case .metadataObjectTypeRequired:
            return "Metadata object type is required for barcode generation."
        case .nonNativeType(let barcodeType):
            return "'\(barcodeType.rawValue)' is not a native barcode type."
        case .sizeRequired:
            return "Size is required for barcode resizing."
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

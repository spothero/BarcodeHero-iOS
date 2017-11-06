//
//  BHError.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

public enum BHError: Error {
//    case generic(String)
    case characterEncodingNotFound(String)
    case couldNotCreateFilter(BHBarcodeType)
    case couldNotCreateGenerator(BHBarcodeType)
    case couldNotCreateImage(BHBarcodeType)
    case couldNotGetGraphicsContext
    case dataRequired
    case imageViewRequired
    case invalidData(String, for: BHBarcodeType)
    case invalidType(BHBarcodeType)
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
        case .couldNotCreateGenerator(let barcodeType):
            return "Could not create generator for barcode type '\(barcodeType)'."
        case .couldNotCreateImage(let barcodeType):
            return "Could not create image for barcode type '\(barcodeType)'."
        case .couldNotGetGraphicsContext:
            return "Coulde not get current graphics context."
        case .dataRequired:
            return "Data is required for barcode generation."
//        case .generic(let message):
//            return message
        case .imageViewRequired:
            return "Image view is required for barcode resizing."
        case .invalidData(let data, let barcodeType):
            return "Data '\(data)' is invalid for barcode type '\(barcodeType.rawValue)'."
        case .invalidType(let barcodeType):
            return "Barcode type '\(barcodeType.rawValue)' is invalid."
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

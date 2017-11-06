//
//  Enums.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import Foundation

public enum BHBarcodeType: String {
//    case unknown = "Unknown"
    case aztec = "Aztec"
    case code39 = "Code 39"
    case code39Mod43 = "Code 39 mod 43"
    case code93 = "Code 93"
    case code128 = "Code 128"
    case dataMatrix = "Data Matrix"
    case ean8 = "EAN 8"
    case ean13 = "EAN 13"
    case extendedCode39 = "Extended Code 39"
    case itf = "Interleaved 2 of 5"
    case itf14 = "ITF 14"
    case isbn13 = "ISBN 13"
    case issn13 = "ISSN 13"
    case pdf417 = "PDF 417"
    case qr = "QR" // swiftlint:disable:this identifier_name
    case upce = "UPCE"

    public static var array: [BHBarcodeType] {
        return [.aztec, .code39, .code39Mod43, .code93, .code128,
                .dataMatrix, .ean8, .ean13, .extendedCode39, .itf,
                .itf14, .isbn13, .issn13, .pdf417, .qr, .upce]
    }

    public var isNative: Bool {
        return [.aztec, .code128, .pdf417, .qr].contains(self)
    }

    init?(metadataObjectType: AVMetadataObject.ObjectType) {
        switch metadataObjectType {
        case .aztec:
            self = .aztec
        case .code39:
            self = .code39
        case .code39Mod43:
            self = .code39Mod43
        case .code93:
            self = .code93
        case .code128:
            self = .code128
        case .dataMatrix:
            self = .dataMatrix
        case .ean8:
            self = .ean8
        case .ean13:
            self = .ean13
        case .interleaved2of5:
            self = .itf
        case .itf14:
            self = .itf14
        case .pdf417:
            self = .pdf417
        case .qr:
            self = .qr
        case .upce:
            self = .upce
        default:
            return nil
        }
    }
}

// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
public enum BHNativeCodeGeneratorType: String {
    case aztec = "CIAztecCodeGenerator"
    case code128 = "CICode128BarcodeGenerator"
    case pdf417 = "CIPDF417BarcodeGenerator"
    case qr = "CIQRCodeGenerator" // swiftlint:disable:this identifier_name

    init?(barcodeType: BHBarcodeType) throws {
        switch barcodeType {
        case .aztec:
            self = BHNativeCodeGeneratorType.aztec
        case .code128:
            self = BHNativeCodeGeneratorType.code128
        case .pdf417:
            self = BHNativeCodeGeneratorType.pdf417
        case .qr:
            self = BHNativeCodeGeneratorType.qr
        default:
            throw BHError.nonNativeType(barcodeType)
        }
    }
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAztecCodeGenerator
public enum BHAztecParameters: String {
    case inputCompactStyle
    case inputCorrectionLevel
    case inputLayers
    case inputMessage
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator
public enum BHCode128Parameters: String {
    case inputMessage
    case inputQuietSpace
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPDF417BarcodeGenerator
public enum BHPDF417Parameters: String {
    case inputMessage
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
public enum BHQRParameters: String {
    case inputCorrectionLevel
    case inputMessage
}

public enum BHQRInputCorrectionLevel: String {
    case low     = "L" // 7%
    case medium  = "M" // 15% (default)
    case quarter = "Q" // 25%
    case high    = "H" // 30%
}

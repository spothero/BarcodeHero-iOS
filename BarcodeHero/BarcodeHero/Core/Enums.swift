//
//  Enums.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

public enum BHBarcodeType: String {
    case aztec = "Aztec"
    case code128 = "Code 128"
    case pdf417 = "PDF 417"
    case qr = "QR" // swiftlint:disable:this identifier_name

    public static var array: [BHBarcodeType] {
        return [.aztec, .code128, .pdf417, .qr]
    }

    public var generator: BHCodeGeneratorType {
        return BHCodeGeneratorType(barcodeType: self)
    }
}

// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
public enum BHCodeGeneratorType: String {
    case aztec = "CIAztecCodeGenerator"
    case code128 = "CICode128BarcodeGenerator"
    case pdf417 = "CIPDF417BarcodeGenerator"
    case qr = "CIQRCodeGenerator" // swiftlint:disable:this identifier_name

    init(barcodeType: BHBarcodeType) {
        switch barcodeType {
        case .aztec:
            self = BHCodeGeneratorType.aztec
        case .code128:
            self = BHCodeGeneratorType.code128
        case .pdf417:
            self = BHCodeGeneratorType.pdf417
        case .qr:
            self = BHCodeGeneratorType.qr
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

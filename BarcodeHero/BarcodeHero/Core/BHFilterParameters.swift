//
//  BHFilterParameters.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/7/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import CoreImage
import Foundation

public protocol BHFilterParameterizable {
    func loadInto(_ filter: CIFilter)
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAztecCodeGenerator
public struct BHAztecFilterParameters: BHFilterParameterizable {
    public var inputCompactStyle: NSNumber
    public var inputCorrectionLevel: NSNumber = 23
    public var inputLayers: NSNumber
    
    public func loadInto(_ filter: CIFilter) {
        filter.setValuesForKeys([
            BHAztecFilterParameterKey.inputCompactStyle.rawValue : inputCompactStyle,
            BHAztecFilterParameterKey.inputCorrectionLevel.rawValue : inputCorrectionLevel,
            BHAztecFilterParameterKey.inputLayers.rawValue : inputLayers
        ])
    }
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator
public struct BHCode128FilterParameters: BHFilterParameterizable {
    public var inputQuietSpace: NSNumber = 7

    public func loadInto(_ filter: CIFilter) {
        filter.setValue(inputQuietSpace, forKey: BHCode128FilterParameterKey.inputQuietSpace.rawValue)
    }
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPDF417BarcodeGenerator
public struct BHPDF417FilterParameters: BHFilterParameterizable {
    public var inputAlwaysSpecifyCompaction: NSNumber
    public var inputCompactionMode: NSNumber
    public var inputCompactStyle: NSNumber
    public var inputCorrectionLevel: NSNumber
    public var inputDataColumns: NSNumber
    public var inputDataRows: NSNumber
    public var inputMaxHeight: NSNumber
    public var inputMaxWidth: NSNumber
    public var inputMinHeight: NSNumber
    public var inputMinWidth: NSNumber
    public var inputPreferredAspectRatio: NSNumber

    public func loadInto(_ filter: CIFilter) {
        filter.setValuesForKeys([
            BHPDF417FilterParameterKey.inputAlwaysSpecifyCompaction.rawValue : inputAlwaysSpecifyCompaction,
            BHPDF417FilterParameterKey.inputCompactionMode.rawValue : inputCompactionMode,
            BHPDF417FilterParameterKey.inputCompactStyle.rawValue : inputCompactStyle,
            BHPDF417FilterParameterKey.inputCorrectionLevel.rawValue : inputCorrectionLevel,
            BHPDF417FilterParameterKey.inputDataColumns.rawValue : inputDataColumns,
            BHPDF417FilterParameterKey.inputDataRows.rawValue : inputDataRows,
            BHPDF417FilterParameterKey.inputMaxHeight.rawValue : inputMaxHeight,
            BHPDF417FilterParameterKey.inputMaxWidth.rawValue : inputMaxWidth,
            BHPDF417FilterParameterKey.inputMinHeight.rawValue : inputMinHeight,
            BHPDF417FilterParameterKey.inputMinWidth.rawValue : inputMinWidth,
            BHPDF417FilterParameterKey.inputPreferredAspectRatio.rawValue : inputPreferredAspectRatio
        ])
    }
}

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
public struct BHQRFilterParameters: BHFilterParameterizable {
    public var inputCorrectionLevel: BHQRInputCorrectionLevel = .medium

    public func loadInto(_ filter: CIFilter) {
        filter.setValue(inputCorrectionLevel, forKey: BHQRFilterParameterKey.inputCorrectionLevel.rawValue)
    }
}

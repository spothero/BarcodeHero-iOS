//
//  BHPDF417FilterParameters.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/10/18.
//  Copyright © 2018 SpotHero, Inc. All rights reserved.
//

import CoreImage
import Foundation

// swiftlint:disable:next line_length
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
            BHPDF417FilterParameterKey.inputAlwaysSpecifyCompaction.rawValue: inputAlwaysSpecifyCompaction,
            BHPDF417FilterParameterKey.inputCompactionMode.rawValue: inputCompactionMode,
            BHPDF417FilterParameterKey.inputCompactStyle.rawValue: inputCompactStyle,
            BHPDF417FilterParameterKey.inputCorrectionLevel.rawValue: inputCorrectionLevel,
            BHPDF417FilterParameterKey.inputDataColumns.rawValue: inputDataColumns,
            BHPDF417FilterParameterKey.inputDataRows.rawValue: inputDataRows,
            BHPDF417FilterParameterKey.inputMaxHeight.rawValue: inputMaxHeight,
            BHPDF417FilterParameterKey.inputMaxWidth.rawValue: inputMaxWidth,
            BHPDF417FilterParameterKey.inputMinHeight.rawValue: inputMinHeight,
            BHPDF417FilterParameterKey.inputMinWidth.rawValue: inputMinWidth,
            BHPDF417FilterParameterKey.inputPreferredAspectRatio.rawValue: inputPreferredAspectRatio,
        ])
    }
}

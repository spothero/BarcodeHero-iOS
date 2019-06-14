//
//  BHQRFilterParameters.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/10/18.
//  Copyright © 2018 SpotHero. All rights reserved.
//

import CoreImage
import Foundation

// swiftlint:disable:next line_length
/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
public struct BHQRFilterParameters: BHFilterParameterizable {
    public var inputCorrectionLevel: BHQRInputCorrectionLevel = .medium

    public func loadInto(_ filter: CIFilter) {
        filter.setValue(self.inputCorrectionLevel, forKey: BHQRFilterParameterKey.inputCorrectionLevel.rawValue)
    }
}

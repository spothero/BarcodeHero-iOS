// Copyright © 2021 SpotHero, Inc. All rights reserved.

import CoreGraphics
import Foundation

public struct BHBarcodeOptions {
    // MARK: Properties
    
    public let fillColor: CGColor?
    public let strokeColor: CGColor?
    public var qrCorrectionLevel: BHQRInputCorrectionLevel = .low
    public let filterParameters: BHFilterParameterizable?
    
    // MARK: Initialization
    
    /// Creates options used to create a barcode.
    /// - Parameter fillColor:          Color used to fill the background. Defaults to white.
    /// - Parameter strokeColor:        Color used to fill the foreground. Defaults to black.
    /// - Parameter filterParameters:   Parameters to set on the filter used when generating a barcode.
    ///                                 Defaults to nil.
    public init(fillColor: CGColor? = nil,
                strokeColor: CGColor? = nil,
                qrCorrectionLevel: BHQRInputCorrectionLevel = .low,
                filterParameters: BHFilterParameterizable? = nil) {
        self.fillColor = fillColor ?? CGColor.systemSafeWhite
        self.strokeColor = strokeColor ?? CGColor.systemSafeBlack
        self.qrCorrectionLevel = qrCorrectionLevel
        self.filterParameters = filterParameters
    }
}

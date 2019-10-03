//
//  BHBarcodeOptions.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import CoreGraphics
import Foundation

public struct BHBarcodeOptions {
    
    // MARK: Properties
    
    public let fillColor: CGColor?
    public let strokeColor: CGColor?

    public let filterParameters: BHFilterParameterizable?
    
    // MARK: Initialization
    
    /// Creates options used to create a barcode.
    /// - Parameter fillColor:          Color used to fill the background. Defaults to white.
    /// - Parameter strokeColor:        Color used to fill the foreground. Defaults to black.
    /// - Parameter filterParameters:   Parameters to set on the filter used when generating a barcode.
    ///                                 Defaults to nil.
    public init(fillColor: CGColor? = nil,
                strokeColor: CGColor? = nil,
                filterParameters: BHFilterParameterizable? = nil) {
        self.fillColor = fillColor ?? CGColor.white
        self.strokeColor = strokeColor ?? CGColor.black
        self.filterParameters = filterParameters
    }
    
}

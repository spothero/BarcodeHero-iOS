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
    public var fillColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1, 1, 1, 1]) // White
    public var strokeColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0, 0, 0, 1]) // Black

    public var filterParameters: BHFilterParameterizable?
}

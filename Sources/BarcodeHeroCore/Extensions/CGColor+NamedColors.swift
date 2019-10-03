//
//  CGColor+NamedColors.swift
//  BarcodeHero
//
//  Created by Kyle Haptonstall on 10/03/19.
//  Copyright © 2019 SpotHero, Inc. All rights reserved.
//

import CoreGraphics

extension CGColor {
    
    static var black: CGColor? {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0, 0, 0, 1])
    }
    
    static var white: CGColor? {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1, 1, 1, 1])
    }
    
}

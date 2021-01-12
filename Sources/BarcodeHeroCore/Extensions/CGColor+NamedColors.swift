// Copyright © 2021 SpotHero, Inc. All rights reserved.

import CoreGraphics

extension CGColor {
    static var systemSafeBlack: CGColor? {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0, 0, 0, 1])
    }
    
    static var systemSafeWhite: CGColor? {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1, 1, 1, 1])
    }
}

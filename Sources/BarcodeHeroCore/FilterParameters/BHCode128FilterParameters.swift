// Copyright © 2019 SpotHero, Inc. All rights reserved.

import CoreImage
import Foundation

/// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator
public struct BHCode128FilterParameters: BHFilterParameterizable {
    public var inputQuietSpace: NSNumber = 7

    public func loadInto(_ filter: CIFilter) {
        filter.setValue(self.inputQuietSpace, forKey: BHCode128FilterParameterKey.inputQuietSpace.rawValue)
    }
}

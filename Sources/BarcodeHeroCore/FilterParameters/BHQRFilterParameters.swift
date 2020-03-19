// Copyright © 2020 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreImage
    import Foundation

    /// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
    public struct BHQRFilterParameters: BHFilterParameterizable {
        public var inputCorrectionLevel: BHQRInputCorrectionLevel = .medium

        public func loadInto(_ filter: CIFilter) {
            filter.setValue(self.inputCorrectionLevel, forKey: BHQRFilterParameterKey.inputCorrectionLevel.rawValue)
        }
    }

#endif

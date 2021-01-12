// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreImage
    import Foundation
    
    // https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAztecCodeGenerator
    public struct BHAztecFilterParameters: BHFilterParameterizable {
        public var inputCompactStyle: NSNumber
        public var inputCorrectionLevel: NSNumber = 23
        public var inputLayers: NSNumber
        
        public func loadInto(_ filter: CIFilter) {
            filter.setValuesForKeys([
                BHAztecFilterParameterKey.inputCompactStyle.rawValue: self.inputCompactStyle,
                BHAztecFilterParameterKey.inputCorrectionLevel.rawValue: self.inputCorrectionLevel,
                BHAztecFilterParameterKey.inputLayers.rawValue: self.inputLayers,
            ])
        }
    }
    
#endif

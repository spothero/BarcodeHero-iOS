// Copyright © 2020 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreImage
    import Foundation
    
    /// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator
    public struct BHCode128FilterParameters: BHFilterParameterizable {
        public var inputQuietSpace: NSNumber = 0 // default is 7 in the native filter generation
        
        public func loadInto(_ filter: CIFilter) {
            filter.setValue(self.inputQuietSpace, forKey: BHCode128FilterParameterKey.inputQuietSpace.rawValue)
        }
    }
    
#endif

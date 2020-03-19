// Copyright © 2019 SpotHero, Inc. All rights reserved.

import Foundation

#if canImport(CoreImage)
import CoreImage
#endif

public protocol BHFilterParameterizable {
    #if canImport(CoreImage)
    func loadInto(_ filter: CIFilter)
    #endif
}


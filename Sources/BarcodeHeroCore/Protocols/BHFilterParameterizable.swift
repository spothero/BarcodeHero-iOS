// Copyright © 2019 SpotHero, Inc. All rights reserved.

import CoreImage
import Foundation

public protocol BHFilterParameterizable {
    func loadInto(_ filter: CIFilter)
}

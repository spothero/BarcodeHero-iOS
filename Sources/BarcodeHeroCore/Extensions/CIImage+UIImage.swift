// Copyright © 2019 SpotHero, Inc. All rights reserved.

#if canImport(UIKit) && (os(iOS) || targetEnvironment(macCatalyst))

    import Foundation
    import UIKit

    extension CIImage {
        var uiImage: UIImage {
            return UIImage(ciImage: self)
        }
    }

#endif

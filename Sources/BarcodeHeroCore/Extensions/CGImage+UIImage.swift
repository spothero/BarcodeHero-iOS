// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if canImport(UIKit)
    
    import Foundation
    import UIKit
    
    extension CGImage {
        var uiImage: UIImage {
            return UIImage(cgImage: self)
        }
    }
    
#endif

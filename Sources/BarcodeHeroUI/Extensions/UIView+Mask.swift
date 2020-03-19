// Copyright © 2020 SpotHero, Inc. All rights reserved.

#if canImport(UIKit)

    import AVFoundation
    import Foundation
    import UIKit

    extension UIView {
        func mask(_ maskRect: CGRect, invert: Bool = false) {
            let maskLayer = CAShapeLayer()
            let path = CGMutablePath()

            if invert {
                path.addRect(bounds)
            }

            path.addRoundedRect(in: maskRect, cornerWidth: 4.0, cornerHeight: 4.0)

            maskLayer.path = path

            if invert {
                maskLayer.fillRule = .evenOdd
            }

            layer.mask = maskLayer
        }
    }

#endif

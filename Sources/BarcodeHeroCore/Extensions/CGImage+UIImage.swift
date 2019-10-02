//
//  CGImage+UIImage.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/01/19.
//  Copyright © 2019 SpotHero, Inc. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

extension CGImage {
    var uiImage: UIImage {
        return UIImage(cgImage: self)
    }
}

#endif

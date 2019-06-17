//
//  CIImage+Transform.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation

extension CIImage {
    var uiImage: UIImage {
        return UIImage(ciImage: self)
    }

    func transformedToFit(_ imageView: UIImageView?) -> CIImage? {
        return self.transformedToFit(imageView?.frame.size)
    }

    func transformedToFit(_ size: CGSize?) -> CIImage? {
        guard let size = size else {
            return nil
        }

        let scaleX = size.width / extent.size.width
        let scaleY = size.height / extent.size.height

        return transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
}

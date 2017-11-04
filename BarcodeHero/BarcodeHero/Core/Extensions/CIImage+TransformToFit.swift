//
//  CIImage+TransformToFit.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

extension CIImage {
    public var uiImage: UIImage {
        return UIImage(ciImage: self)
    }

    public func transformToFit(_ imageView: UIImageView?) -> CIImage? {
        return transformToFit(imageView?.frame.size)
    }

    public func transformToFit(_ size: CGSize?) -> CIImage? {
        guard let size = size else {
            return nil
        }

        let scaleX = size.width / extent.size.width
        let scaleY = size.height / extent.size.height

        return transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
}

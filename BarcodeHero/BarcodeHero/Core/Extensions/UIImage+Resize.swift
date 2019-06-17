//
//  UIImage+Resize.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation

extension UIImage {
    public func bh_resizedTo(_ imageView: UIImageView?) throws -> UIImage? {
        guard let imageView = imageView else {
            throw BHError.imageViewRequired
        }

        return try self.bh_resizedTo(imageView.bounds.size, forContentMode: imageView.contentMode)
    }

    public func bh_resizedTo(_ size: CGSize?, forContentMode contentMode: UIView.ContentMode? = nil) throws -> UIImage? {
        guard let size = size else {
            throw BHError.sizeRequired
        }

        if let ciImage = ciImage {
            return ciImage.transformedToFit(size)?.uiImage
        } else {
            let contentMode = contentMode ?? .scaleAspectFit
            return try BHImageHelper.resize(self, toSize: size, forContentMode: contentMode)
        }
    }
}

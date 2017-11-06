//
//  UIImage+Resize.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

extension UIImage {
    public func resizeTo(_ imageView: UIImageView?) throws  -> UIImage? {
        guard let imageView = imageView else {
            throw BHError.imageViewRequired
        }

        return try resizeTo(imageView.bounds.size, forContentMode: imageView.contentMode)
    }

    public func resizeTo(_ size: CGSize?, forContentMode contentMode: UIViewContentMode? = nil) throws -> UIImage? {
        guard let size = size else {
            throw BHError.sizeRequired
        }

        if let ciImage = ciImage {//} ?? CIImage(image: self) { // ?? CIImage(cgImage: cgImage)
            return ciImage.transformToFit(size)?.uiImage
        }
        else {
            let contentMode = contentMode ?? .scaleAspectFit
            return try BHImageHelper.resize(self, toSize: size, forContentMode: contentMode)
        }
    }
}


//
//  UIImage+Resize.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation

extension UIImage {
    
    /// Resizes an image based on the size and contentMode of the passed in imageView
    /// - Parameter imageView: The imageView whose size and contentMode should be referenced
    public func bh_resizedTo(_ imageView: UIImageView) throws -> UIImage? {
        return try self.bh_resizedTo(imageView.bounds.size, forContentMode: imageView.contentMode)
    }

    public func bh_resizedTo(_ size: CGSize, forContentMode contentMode: UIView.ContentMode? = nil) throws -> UIImage? {
        if let ciImage = self.ciImage {
            return ciImage.transformedToFit(size)?.uiImage
        } else {
            let contentMode = contentMode ?? .scaleAspectFit
            return try BHImageHelper.resize(self, toSize: size, forContentMode: contentMode)
        }
    }
}

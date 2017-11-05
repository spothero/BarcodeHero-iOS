//
//  UIImage+Transform.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

extension UIImage {
    public func transformToFit(_ imageView: UIImageView?) -> UIImage? {
        return transformToFit(imageView?.frame.size)
    }

    public func transformToFit(_ size: CGSize?) -> UIImage? {
        guard let size = size else {
            return nil
        }

        if let ciImage = ciImage {//} ?? CIImage(image: self) { // ?? CIImage(cgImage: cgImage)
            return ciImage.transformToFit(size)?.uiImage
        }
        else {
            var scaledImageRect = CGRect.zero

            let aspectWidth = size.width / self.size.width
            let aspectHeight = size.height / self.size.height
            let aspectRatio = min(aspectWidth, aspectHeight)

            scaledImageRect.size.width = self.size.width * aspectRatio
            scaledImageRect.size.height = self.size.height * aspectRatio
            scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
            scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0

            UIGraphicsBeginImageContextWithOptions(size, false, 0)

            self.draw(in: scaledImageRect)

            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()

            return scaledImage
        }
    }

//    public func scaledTo(imageView: UIImageView?) -> UIImage? {
//        return scaledTo(size: imageView?.frame.size)
//    }
//
//    public func scaledTo(size: CGSize?) -> UIImage? {
//        guard let size = size else {
//            return nil
//        }
//
//        let hasAlpha = false
//        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
//
//        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
//        self.draw(in: CGRect(origin: .zero, size: size))
//
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return scaledImage
//    }
}


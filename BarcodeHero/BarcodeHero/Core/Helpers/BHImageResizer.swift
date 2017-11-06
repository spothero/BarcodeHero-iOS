////
////  BHImageResizer.swift
////  BarcodeHero
////
////  Created by Brian Drelling on 10/19/17.
////  Copyright © 2017 SpotHero. All rights reserved.
////
//
//import AVFoundation
//import CoreImage
//import Foundation
//import UIKit
//
//public class BHImageResizer {
//    public static func resize(_ source: UIImage, scale: CGFloat) -> UIImage? {
//        let width = source.size.width * scale
//        let height = source.size.height * scale
//
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//        if let context = UIGraphicsGetCurrentContext() {
//            context.interpolationQuality = CGInterpolationQuality.none
//            source.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//            let target = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return target
//        } else {
//            return nil
//        }
//    }
//
//    public static func resize(_ source: UIImage, targetSize: CGSize, contentMode: UIViewContentMode) -> UIImage? {
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//        var width = targetSize.width
//        var height = targetSize.height
//        if contentMode == UIViewContentMode.scaleToFill { // contents scaled to fill
//            // Nothing to do
//        } else if contentMode == UIViewContentMode.scaleAspectFill { // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//            let targtLength  = (targetSize.height > targetSize.width)   ? targetSize.height  : targetSize.width
//            let sourceLength = (source.size.height < source.size.width) ? source.size.height : source.size.width
//            let fillScale = targtLength / sourceLength
//            width = source.size.width * fillScale
//            height = source.size.height * fillScale
//            x = (targetSize.width  - width)  / 2.0
//            y = (targetSize.height - height) / 2.0
//        } else { // contents scaled to fit with fixed aspect. remainder is transparent
//            let scaledRect = AVMakeRect(aspectRatio: source.size, insideRect: CGRect(x: 0.0, y: 0.0, width: targetSize.width, height: targetSize.height))
//            width = scaledRect.width
//            height = scaledRect.height
//            if contentMode == UIViewContentMode.scaleAspectFit
//                || contentMode == UIViewContentMode.redraw
//                || contentMode == UIViewContentMode.center {
//                x = (targetSize.width  - width)  / 2.0
//                y = (targetSize.height - height) / 2.0
//            } else if contentMode == UIViewContentMode.top {
//                x = (targetSize.width  - width)  / 2.0
//                y = 0
//            } else if contentMode == UIViewContentMode.bottom {
//                x = (targetSize.width  - width)  / 2.0
//                y = targetSize.height - height
//            } else if contentMode == UIViewContentMode.left {
//                x = 0
//                y = (targetSize.height - height) / 2.0
//            } else if contentMode == UIViewContentMode.right {
//                x = targetSize.width  - width
//                y = (targetSize.height - height) / 2.0
//            } else if contentMode == UIViewContentMode.topLeft {
//                x = 0
//                y = 0
//            } else if contentMode == UIViewContentMode.topRight {
//                x = targetSize.width  - width
//                y = 0
//            } else if contentMode == UIViewContentMode.bottomLeft {
//                x = 0
//                y = targetSize.height - height
//            } else if contentMode == UIViewContentMode.bottomRight {
//                x = targetSize.width  - width
//                y = targetSize.height - height
//            }
//        }
//
//        UIGraphicsBeginImageContext(targetSize)
//        if let context = UIGraphicsGetCurrentContext() {
//            context.interpolationQuality = CGInterpolationQuality.none
//            source.draw(in: CGRect(x: x, y: y, width: width, height: height))
//            let target = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return target
//        } else {
//            return nil
//        }
//    }
//}
//

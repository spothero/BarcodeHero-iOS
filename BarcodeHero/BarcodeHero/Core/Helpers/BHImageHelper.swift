//
//  BHImageHelper.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import CoreImage
import Foundation
import UIKit

class BHImageHelper {
    static func draw(_ data: String, options: BHBarcodeOptions? = nil) throws -> UIImage? {
        guard !data.isEmpty else {
            throw BHError.dataRequired
        }

        let options = options ?? BHBarcodeOptions()

        // Values taken from CIImage generated AVMetadataObjectTypePDF417Code type image
        // Top spacing          = 1.5
        // Bottom spacing       = 2
        // Left & right spacing = 2
        // Height               = 28
        let width = data.count + 4
        let size = CGSize(width: CGFloat(width), height: 28)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            throw BHError.couldNotGetGraphicsContext
        }

        context.setShouldAntialias(false)

        options.fillColor.setFill()
        options.strokeColor.setStroke()

        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        context.setLineWidth(1)

        for index in 0 ..< data.count {
            guard data[index] == "1" else {
                continue
            }

            let x = index + (2 + 1)
            context.move(to: CGPoint(x: CGFloat(x), y: 1.5))
            context.addLine(to: CGPoint(x: CGFloat(x), y: size.height - 2))
        }

        context.drawPath(using: CGPathDrawingMode.fillStroke)

        let barcode = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return barcode
    }

    static func resize(_ image: UIImage, scale: CGFloat) throws -> UIImage? {
        let width = image.size.width * scale
        let height = image.size.height * scale

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.interpolationQuality = CGInterpolationQuality.none

        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        let target = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return target
    }

    static func resize(_ image: UIImage,
                       toSize targetSize: CGSize,
                       forContentMode contentMode: UIView.ContentMode = .scaleAspectFit) throws -> UIImage? {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width = targetSize.width
        var height = targetSize.height

        switch contentMode {
        case .scaleToFill:
            // do nothing
            break
        case .scaleAspectFill:
            // contents scaled to fill with fixed aspect. some portion of content may be clipped.
            let targtLength = (targetSize.height > targetSize.width) ? targetSize.height : targetSize.width
            let sourceLength = (image.size.height < image.size.width) ? image.size.height : image.size.width
            let fillScale = targtLength / sourceLength
            width = image.size.width * fillScale
            height = image.size.height * fillScale
            x = (targetSize.width - width) / 2.0
            y = (targetSize.height - height) / 2.0
        default:
            let scaledRect = AVMakeRect(aspectRatio: image.size,
                                        insideRect: CGRect(x: 0.0, y: 0.0, width: targetSize.width, height: targetSize.height))

            width = scaledRect.width
            height = scaledRect.height

            switch contentMode {
            case .scaleAspectFit, .redraw, .center:
                x = (targetSize.width - width) / 2.0
                y = (targetSize.height - height) / 2.0
            case .top:
                x = (targetSize.width - width) / 2.0
                y = 0
            case .bottom:
                x = (targetSize.width - width) / 2.0
                y = targetSize.height - height
            case .left:
                x = 0
                y = (targetSize.height - height) / 2.0
            case .right:
                x = targetSize.width - width
                y = (targetSize.height - height) / 2.0
            case .topLeft:
                x = 0
                y = 0
            case .topRight:
                x = targetSize.width - width
                y = 0
            case .bottomLeft:
                x = 0
                y = targetSize.height - height
            case .bottomRight:
                x = targetSize.width - width
                y = targetSize.height - height
            default:
                break
            }
        }

        UIGraphicsBeginImageContext(targetSize)

        guard let context = UIGraphicsGetCurrentContext() else {
            throw BHError.couldNotGetGraphicsContext
        }

//        context.setShouldAntialias(false)
        context.interpolationQuality = CGInterpolationQuality.none

        image.draw(in: CGRect(x: x, y: y, width: width, height: height))

        let target = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return target
    }
}

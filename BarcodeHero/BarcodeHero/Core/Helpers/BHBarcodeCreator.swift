//
//  BHBarcodeCreator.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation

class BHBarcodeCreator {
    static func draw(_ data: String) throws -> UIImage? {
        guard !data.isEmpty else {
            throw BHError.dataRequired
        }

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

        UIColor.white.setFill()
        UIColor.black.setStroke()

        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        context.setLineWidth(1)

        for i in 0 ..< data.count {
            guard data[i] == "1" else {
                continue
            }

            let x = i + (2 + 1)
            context.move(to: CGPoint(x: CGFloat(x), y: 1.5))
            context.addLine(to: CGPoint(x: CGFloat(x), y: size.height - 2))
        }

        context.drawPath(using: CGPathDrawingMode.fillStroke)

        let barcode = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return barcode
    }
}

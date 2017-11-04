//
//  RSAbstractBarcodeGenerator.swift
//  HTBarcodeGenerator
//
//  Created by Brian Drelling on 10/18/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import CoreImage
import Foundation
import UIKit

// Abstract code generator, provides default functions for validations and generations.
open class RSAbstractCodeGenerator : RSCodeGenerator {

    open var fillColor: UIColor = UIColor.white
    open var strokeColor: UIColor = UIColor.black

    // Check whether the given contents are valid.
    open func isValid(_ contents:String) -> Bool {
        let length = contents.length()
        if length > 0 {
            for i in 0..<length {
                if !DIGITS_STRING.contains(contents[i]) {
                    return false
                }
            }
            return true
        }
        return false
    }

    // Barcode initiator, subclass should return its own value.
    open func initiator() -> String {
        return ""
    }

    // Barcode terminator, subclass should return its own value.
    open func terminator() -> String {
        return ""
    }

    // Barcode content, subclass should return its own value.
    open func barcode(_ contents:String) -> String {
        return ""
    }

    // Composer for combining barcode initiator, contents, terminator together.
    func completeBarcode(_ barcode:String) -> String {
        return self.initiator() + barcode + self.terminator()
    }

    // Drawer for completed barcode.
    func drawCompleteBarcode(_ completeBarcode:String) -> UIImage? {
        let length:Int = completeBarcode.length()
        if length <= 0 {
            return nil
        }

        // Values taken from CIImage generated AVMetadataObjectTypePDF417Code type image
        // Top spacing          = 1.5
        // Bottom spacing       = 2
        // Left & right spacing = 2
        // Height               = 28
        let width = length + 4
        let size = CGSize(width: CGFloat(width), height: 28)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setShouldAntialias(false)

            self.fillColor.setFill()
            self.strokeColor.setStroke()

            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            context.setLineWidth(1)

            for i in 0..<length {
                if completeBarcode[i] == "1" {
                    let x = i + (2 + 1)
                    context.move(to: CGPoint(x: CGFloat(x), y: 1.5))
                    context.addLine(to: CGPoint(x: CGFloat(x), y: size.height - 2))
                }
            }
            context.drawPath(using: CGPathDrawingMode.fillStroke)
            let barcode = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return barcode
        } else {
            return nil
        }
    }

    // RSCodeGenerator

    open func generateCode(_ machineReadableCodeObject:AVMetadataMachineReadableCodeObject, inputCorrectionLevel: InputCorrectionLevel) -> UIImage? {
        return self.generateCode(machineReadableCodeObject.stringValue!, inputCorrectionLevel: inputCorrectionLevel, machineReadableCodeObjectType: machineReadableCodeObject.type.rawValue)
    }

    open func generateCode(_ machineReadableCodeObject:AVMetadataMachineReadableCodeObject) -> UIImage? {
        return self.generateCode(machineReadableCodeObject, inputCorrectionLevel: .Medium)
    }

    open func generateCode(_ contents:String, inputCorrectionLevel:InputCorrectionLevel, machineReadableCodeObjectType:String) -> UIImage? {
        if self.isValid(contents) {
            return self.drawCompleteBarcode(self.completeBarcode(self.barcode(contents)))
        }
        return nil
    }

    open func generateCode(_ contents:String, machineReadableCodeObjectType:String) -> UIImage? {
        return self.generateCode(contents, inputCorrectionLevel: .Medium, machineReadableCodeObjectType: machineReadableCodeObjectType)
    }

    // Class funcs

    // Get CIFilter name by machine readable code object type
    open class func filterName(_ machineReadableCodeObjectType:String) -> String {
        if machineReadableCodeObjectType == AVMetadataObject.ObjectType.qr.rawValue {
            return "CIQRCodeGenerator"
        } else if machineReadableCodeObjectType == AVMetadataObject.ObjectType.pdf417.rawValue {
            return "CIPDF417BarcodeGenerator"
        } else if machineReadableCodeObjectType == AVMetadataObject.ObjectType.aztec.rawValue {
            return "CIAztecCodeGenerator"
        } else if machineReadableCodeObjectType == AVMetadataObject.ObjectType.code128.rawValue {
            return "CICode128BarcodeGenerator"
        } else {
            return ""
        }
    }

    // Generate CI related code image
    open class func generateCode(_ contents:String, inputCorrectionLevel: InputCorrectionLevel, filterName:String) -> UIImage? {
        if filterName.length() > 0 {
            if let filter = CIFilter(name: filterName) {
                filter.setDefaults()
                let inputMessage = contents.data(using: String.Encoding.utf8, allowLossyConversion: false)
                filter.setValue(inputMessage, forKey: "inputMessage")
                if filterName == "CIQRCodeGenerator" {
                    filter.setValue(inputCorrectionLevel.rawValue, forKey: "inputCorrectionLevel")
                }
                if let outputImage = filter.outputImage {
                    if let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent) {
                        return UIImage(cgImage: cgImage, scale: 1, orientation: UIImageOrientation.up)
                    }
                }
            }
        }
        return nil
    }

    open class func generateCode(_ contents:String, filterName:String) -> UIImage? {
        return self.generateCode(contents, inputCorrectionLevel: .Medium, filterName: filterName)
    }
}

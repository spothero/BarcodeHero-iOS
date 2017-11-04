//
//  RSCodeGenerator.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreImage

// swiftlint:disable identifier_name

let DIGITS_STRING = "0123456789"

// Controls the amount of additional data encoded in the output image to provide error correction.
// Higher levels of error correction result in larger output images but allow larger areas of the code to be damaged or obscured without.
public enum InputCorrectionLevel: String {
    case Low     = "L" // 7%
    case Medium  = "M" // 15% default
    case Quarter = "Q" // 25%
    case High    = "H" // 30%
}

// Code generators are required to provide these two functions.
public protocol RSCodeGenerator {
    /** The fill (background) color of the generated barcode. */
    var fillColor: UIColor {get set}
    
    /** The stroke color of the generated barcode. */
    var strokeColor: UIColor {get set}
    
    /** Check whether the given contents are valid. */
    func isValid(_ contents: String) -> Bool
    
    /** Generate code image using the given machine readable code object and correction level. */
    func generateCode(_ machineReadableCodeObject: AVMetadataMachineReadableCodeObject, inputCorrectionLevel: InputCorrectionLevel) -> UIImage?
    
    /** Generate code image using the given machine readable code object. */
    func generateCode(_ machineReadableCodeObject: AVMetadataMachineReadableCodeObject) -> UIImage?
    
    /** Generate code image using the given machine readable code object type, contents and correction level. */
    func generateCode(_ contents: String, inputCorrectionLevel:InputCorrectionLevel, machineReadableCodeObjectType: String) -> UIImage?
    
    /** Generate code image using the given machine readable code object type and contents. */
    func generateCode(_ contents: String, machineReadableCodeObjectType: String) -> UIImage?
}

// Check digit are not required for all code generators.
// UPC-E is using check digit to valid the contents to be encoded.
// Code39Mod43, Code93 and Code128 is using check digit to encode barcode.
public protocol RSCheckDigitGenerator {
    func checkDigit(_ contents: String) -> String
}



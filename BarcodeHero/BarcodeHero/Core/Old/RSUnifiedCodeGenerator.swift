//
//  RSUnifiedCodeGenerator.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// swiftlint:disable identifier_name

open class RSUnifiedCodeGenerator: RSCodeGenerator {
    
    open var isBuiltInCode128GeneratorSelected = false
    open var fillColor: UIColor = UIColor.white
    open var strokeColor: UIColor = UIColor.black
    
    open class var shared: RSUnifiedCodeGenerator {
        return UnifiedCodeGeneratorSharedInstance
    }
    
    // MARK: RSCodeGenerator
    
    open func isValid(_ contents: String) -> Bool {
        print("Use RSUnifiedCodeValidator.shared.isValid(contents:String, machineReadableCodeObjectType: String) instead")
        return false
    }
    
    open func generateCode(_ contents: String, inputCorrectionLevel: InputCorrectionLevel, machineReadableCodeObjectType: String) -> UIImage? {
        var codeGenerator: RSCodeGenerator?
        switch machineReadableCodeObjectType {
        case AVMetadataObject.ObjectType.interleaved2of5.rawValue:
            codeGenerator = RSITFGenerator()
        case AVMetadataObject.ObjectType.itf14.rawValue:
            codeGenerator = RSITF14Generator()
        case AVMetadataObject.ObjectType.upce.rawValue:
            codeGenerator = RSUPCEGenerator()
        case AVMetadataObject.ObjectType.code93.rawValue:
            codeGenerator = RSCode93Generator()
        case AVMetadataObject.ObjectType.dataMatrix.rawValue:
            codeGenerator = RSCodeDataMatrixGenerator()
        case RSBarcodesTypeExtendedCode39Code:
            codeGenerator = RSExtendedCode39Generator()
        default:
            print("No code generator selected.")
        }
        
        if codeGenerator != nil {
            codeGenerator!.fillColor = self.fillColor
            codeGenerator!.strokeColor = self.strokeColor
            return codeGenerator!.generateCode(contents, inputCorrectionLevel: inputCorrectionLevel, machineReadableCodeObjectType: machineReadableCodeObjectType)
        } else {
            return nil
        }
    }
    
    open func generateCode(_ contents: String, machineReadableCodeObjectType: String) -> UIImage? {
        return self.generateCode(contents, inputCorrectionLevel: .Medium, machineReadableCodeObjectType: machineReadableCodeObjectType)
    }
    
    open func generateCode(_ machineReadableCodeObject: AVMetadataMachineReadableCodeObject, inputCorrectionLevel: InputCorrectionLevel) -> UIImage? {
        return self.generateCode(machineReadableCodeObject.stringValue!, inputCorrectionLevel: inputCorrectionLevel, machineReadableCodeObjectType: machineReadableCodeObject.type.rawValue)
    }
    
    open func generateCode(_ machineReadableCodeObject: AVMetadataMachineReadableCodeObject) -> UIImage? {
        return self.generateCode(machineReadableCodeObject, inputCorrectionLevel: .Medium)
    }
}

let UnifiedCodeGeneratorSharedInstance = RSUnifiedCodeGenerator()

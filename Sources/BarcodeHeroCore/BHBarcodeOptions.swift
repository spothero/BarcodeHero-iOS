//
//  BHBarcodeOptions.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

public struct BHBarcodeOptions {

    #if canImport(UIKit)
    public var fillColor = UIColor.white
    public var strokeColor = UIColor.black
    #endif

    public var filterParameters: BHFilterParameterizable?
}

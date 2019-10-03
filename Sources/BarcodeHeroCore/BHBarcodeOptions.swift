//
//  BHBarcodeOptions.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import CoreGraphics
import UIKit

public struct BHBarcodeOptions {
    
    // MARK: Properties
    
    public let fillColor: CGColor
    public let strokeColor: CGColor

    public let filterParameters: BHFilterParameterizable?
    
    // MARK: Initialization
    
    public init(fillColor: CGColor = UIColor.white.cgColor,
                strokeColor: CGColor = UIColor.black.cgColor,
                filterParameters: BHFilterParameterizable? = nil) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.filterParameters = filterParameters
    }
    
}

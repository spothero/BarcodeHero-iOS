//
//  BHBarcodeOptions.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation

public struct BHBarcodeOptions {
    
    // MARK: Properties
    
    public let fillColor: UIColor
    public let strokeColor: UIColor

    public let filterParameters: BHFilterParameterizable?
    
    // MARK: Initialization
    
    public init(fillColor: UIColor = .white,
                strokeColor: UIColor = .black,
                filterParameters: BHFilterParameterizable? = nil) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.filterParameters = filterParameters
    }
    
}

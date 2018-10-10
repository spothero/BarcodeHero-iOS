//
//  BHFilterParameterizable.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 11/7/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import CoreImage
import Foundation

public protocol BHFilterParameterizable {
    func loadInto(_ filter: CIFilter)
}

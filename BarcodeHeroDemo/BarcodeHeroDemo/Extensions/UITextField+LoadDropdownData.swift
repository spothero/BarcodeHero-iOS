//
//  UITextField+LoadDropdownData.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    public func loadDropdownData(data: [String]) {
        self.inputView = BHPickerView(pickerData: data, dropdownField: self)
    }
}

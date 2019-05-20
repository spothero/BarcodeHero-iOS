//
//  BHPickerView.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import Foundation
import UIKit

class BHPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    private let pickerData: [String]
    private let pickerTextField: UITextField

    init(pickerData: [String], dropdownField: UITextField) {
        self.pickerData = pickerData
        self.pickerTextField = dropdownField

        if pickerData.isEmpty {
            self.pickerTextField.text = nil
            self.pickerTextField.isEnabled = false
        } else {
            self.pickerTextField.text = self.pickerData[0]
            self.pickerTextField.isEnabled = true
        }

        super.init(frame: CGRect.zero)

        delegate = self
        dataSource = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sets number of columns in picker view
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    // Sets the number of rows in the picker view
    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return self.pickerData.count
    }

    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return self.pickerData[row]
    }

    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        self.pickerTextField.text = self.pickerData[row]
    }
}

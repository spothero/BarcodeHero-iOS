// Copyright © 2021 SpotHero, Inc. All rights reserved.

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
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerTextField.text = self.pickerData[row]
    }
}

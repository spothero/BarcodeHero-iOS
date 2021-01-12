// Copyright © 2021 SpotHero, Inc. All rights reserved.

import Foundation
import UIKit

public extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = BHPickerView(pickerData: data, dropdownField: self)
    }
}

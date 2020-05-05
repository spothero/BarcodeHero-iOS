// Copyright © 2020 SpotHero, Inc. All rights reserved.

import BarcodeHeroCore
import BarcodeHeroUI
import Foundation
import UIKit

class BarcodeTypeCell: UITableViewCell {
    @IBOutlet private(set) var typeLabel: UILabel!
    
    var type: BHBarcodeType? {
        didSet {
            self.typeLabel?.text = self.type?.rawValue
        }
    }
}

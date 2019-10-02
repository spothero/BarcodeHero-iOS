//
//  BarcodeTypeCell.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

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

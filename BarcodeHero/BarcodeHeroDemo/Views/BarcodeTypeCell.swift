//
//  BarcodeTypeCell.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import BarcodeHero
import Foundation
import UIKit

class BarcodeTypeCell: UITableViewCell {
    @IBOutlet private(set) var nameLabel: UILabel?

    var type: BHBarcodeType? {
        didSet {
            nameLabel?.text = type?.rawValue
        }
    }
}

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
    @IBOutlet private(set) var typeLabel: UILabel!

    var type: BHBarcodeType? {
        didSet {
            typeLabel?.text = type?.rawValue
        }
    }
}

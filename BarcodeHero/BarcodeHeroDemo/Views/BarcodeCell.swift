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

class BarcodeCell: UITableViewCell {
    @IBOutlet private var alertLabel: UILabel!
    @IBOutlet private var barcodeImageView: UIImageView!
    @IBOutlet private var typeLabel: UILabel!

    func load(_ barcodeType: BHBarcodeType?, withData rawData: String?) {
        self.typeLabel?.text = barcodeType?.rawValue

        do {
            let image = try BHBarcodeGenerator.generate(barcodeType, withData: rawData).bh_resizedTo(self.barcodeImageView)

            self.alertLabel?.isHidden = true
            self.alertLabel?.text = ""

            self.barcodeImageView?.image = image
            self.barcodeImageView?.isHidden = false
        } catch {
            self.alertLabel?.isHidden = false
            self.alertLabel?.text = error.localizedDescription

            self.barcodeImageView?.image = nil
            self.barcodeImageView?.isHidden = true

            print(error.localizedDescription)
        }
    }
}

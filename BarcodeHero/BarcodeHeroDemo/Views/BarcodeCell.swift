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
        typeLabel?.text = barcodeType?.rawValue

        do {
            let image = try BHBarcodeGenerator.generate(barcodeType, withData: rawData).bh_resizedTo(barcodeImageView)

            alertLabel?.isHidden = true
            alertLabel?.text = ""

            barcodeImageView?.image = image
            barcodeImageView?.isHidden = false
        } catch {
            alertLabel?.isHidden = false
            alertLabel?.text = error.localizedDescription

            barcodeImageView?.image = nil
            barcodeImageView?.isHidden = true

            print(error.localizedDescription)
        }
    }
}

//
//  MultiGeneratorController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/5/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import BarcodeHero
import Foundation
import UIKit

class MultiGeneratorController: UITableViewController {
    // MARK: - Properties

    @IBOutlet private var dataTextField: UITextField!

    @IBOutlet private var barcodeImageViewWidthConstraint: NSLayoutConstraint!

    private var data: String = "12345678"
    private var types: [BHBarcodeType] = BHBarcodeType.allCases

    // MARK: - Methods

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }

    // MARK: Overrides (UITableView)

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BarcodeCell",
                                                       for: indexPath) as? BarcodeCell else {
            return UITableViewCell()
        }

        let type = types[indexPath.row]

        cell.load(type, withData: data)

        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
//        let type = types[indexPath.row]
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return types.count
    }
}

// MARK: - Extensions

extension MultiGeneratorController: UITextFieldDelegate {
    public func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)

        return true
    }
}

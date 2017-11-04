//
//  BarcodeTypesController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/4/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import BarcodeHero
import Foundation
import UIKit

class BarcodeTypesController: UITableViewController {
    // MARK: - Properties

    var selectedType: BHBarcodeType?

    weak var delegate: BarcodeTypesControllerDelegate?

    lazy var types: [BHBarcodeType] = {
        return BHBarcodeType.array
    }()

    // MARK: - Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BarcodeTypeCell",
                                                       for: indexPath) as? BarcodeTypeCell else {
            return UITableViewCell()
        }

        let type = types[indexPath.row]

        if let selectedType = selectedType, selectedType == type {
            cell.accessoryType = .checkmark
        }

        cell.type = type

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]

        delegate?.didSelectType(type: type)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
}

// MARK: - Delegate

protocol BarcodeTypesControllerDelegate: class {
    func didSelectType(type: BHBarcodeType)
}

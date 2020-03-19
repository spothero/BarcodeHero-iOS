// Copyright © 2020 SpotHero, Inc. All rights reserved.

import BarcodeHeroCore
import BarcodeHeroUI
import Foundation
import UIKit

class BarcodeTypesController: UITableViewController {
    // MARK: - Properties

    var selectedType: BHBarcodeType?

    weak var delegate: BarcodeTypesControllerDelegate?

    private var types: [BHBarcodeType] = BHBarcodeType.allCases

    // MARK: - Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BarcodeTypeCell",
                                                       for: indexPath) as? BarcodeTypeCell else {
            return UITableViewCell()
        }

        let type = self.types[indexPath.row]

        if let selectedType = selectedType, selectedType == type {
            cell.accessoryType = .checkmark
        }

        cell.type = type

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = self.types[indexPath.row]

        self.delegate?.didSelectType(type: type)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.types.count
    }
}

// MARK: - Delegate

protocol BarcodeTypesControllerDelegate: AnyObject {
    func didSelectType(type: BHBarcodeType)
}

// Copyright © 2021 SpotHero, Inc. All rights reserved.

import AVFoundation
import BarcodeHeroCore
import BarcodeHeroUI
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
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400
    }
    
    // MARK: Overrides (UITableView)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BarcodeCell",
                                                       for: indexPath) as? BarcodeCell else {
            return UITableViewCell()
        }
        
        let type = self.types[indexPath.row]
        
        cell.load(type, withData: self.data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let type = types[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.types.count
    }
}

// MARK: - Extensions

extension MultiGeneratorController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
}

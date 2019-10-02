//
//  ViewController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 10/18/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import BarcodeHeroUI
import UIKit

class MainViewController: UITableViewController {
    // MARK: - Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            switch indexPath.row {
            case 0:
                let controller = BHCameraScanController()
                show(controller, sender: nil)
            default:
                break
            }
        default:
            break
        }
    }
}

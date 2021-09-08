// Copyright © 2021 SpotHero, Inc. All rights reserved.

import AVFoundation
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
                let controller = BHCameraScanController(delegate: self)
                show(controller, sender: nil)
            default:
                break
            }
        default:
            break
        }
    }
}

// MARK: -  BHCameraScanControllerDelegate

extension MainViewController: BHCameraScanControllerDelegate {
    func didCapture(metadataObjects: [AVMetadataObject], from controller: BHBaseCameraScanController) { }
}

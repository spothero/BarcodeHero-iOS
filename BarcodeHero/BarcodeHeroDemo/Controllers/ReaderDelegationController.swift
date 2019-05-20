//
//  ReaderDelegationController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import BarcodeHero
import Foundation
import UIKit

class ReaderDelegationController: UIViewController {
    @IBOutlet private var dataLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataLabel?.text = ""
        typeLabel?.text = ""
    }

    @IBAction private func onScanButtonTapped() {
        let controller = BHCameraScanController()
        controller.delegate = self

        show(controller, sender: nil)
    }
}

extension ReaderDelegationController: BHCameraScanControllerDelegate {
    func didCapture(metadataObjects: [AVMetadataObject], from controller: BHCameraScanController) {
        let firstObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject

        dataLabel?.text = firstObject?.stringValue
        typeLabel?.text = firstObject?.type.rawValue

        navigationController?.popToViewController(self, animated: true)

        controller.stopCapturing()
    }
}

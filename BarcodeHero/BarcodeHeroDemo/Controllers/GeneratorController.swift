//
//  GeneratorController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import AVFoundation
import BarcodeHero
import Foundation
import UIKit

class GeneratorController: UIViewController {
    // MARK: - Properties

    @IBOutlet private var alertLabel: UILabel!
    @IBOutlet private var alertView: UIView!
    @IBOutlet private var barcodeImageView: UIImageView!
    @IBOutlet private var dataTextField: UITextField!
    @IBOutlet private var sizeSlider: UISlider!
    @IBOutlet private var typeLabel: UILabel!

    @IBOutlet private var barcodeImageViewWidthConstraint: NSLayoutConstraint!

    private var data: String = "12345678"
    private var type: BHBarcodeType = .qr

    // MARK: - Methods

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataTextField?.returnKeyType = .done
        self.dataTextField?.delegate = self
        self.dataTextField?.text = self.data

        self.typeLabel?.text = self.type.rawValue

        let generateBarButtonItem = UIBarButtonItem(title: "Generate", style: .plain, target: self, action: #selector(self.onGenerateButtonTapped))
        navigationItem.rightBarButtonItem = generateBarButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.regenerateBarcode()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? BarcodeTypesController else {
            return
        }

        controller.delegate = self
        controller.selectedType = self.type
    }

    // MARK: Actions

    @IBAction private func onDataTextFieldEditingChanged(textField: UITextField?) {
        self.data = textField?.text ?? ""

        self.regenerateBarcode()
    }

    @IBAction private func onSliderValueChanged(slider: UISlider?) {
        guard var sliderValue = slider?.value else {
            return
        }

        if sliderValue < 0.1 {
            sliderValue = 0.1
        } else if sliderValue > 1 {
            sliderValue = 1
        }

        self.barcodeImageView?.transform = CGAffineTransform(scaleX: CGFloat(sliderValue), y: CGFloat(sliderValue))
    }

    // MARK: Events

    @objc
    func onGenerateButtonTapped() {
        view.endEditing(true)
        self.regenerateBarcode()
    }

    // MARK: Utilities

    func regenerateBarcode() {
        do {
            self.alertView?.isHidden = true

            let image = try BHBarcodeGenerator.generate(self.type, withData: self.data).bh_resizedTo(self.barcodeImageView)
            self.barcodeImageView?.image = image
        } catch {
            self.alertLabel?.text = error.localizedDescription
            self.alertView?.isHidden = false

            self.barcodeImageView?.image = nil
            print(error.localizedDescription)
        }
    }
}

// MARK: - Extensions

extension GeneratorController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)

        return true
    }
}

extension GeneratorController: BarcodeTypesControllerDelegate {
    func didSelectType(type: BHBarcodeType) {
        self.type = type

        self.typeLabel?.text = type.rawValue

        navigationController?.popToViewController(self, animated: true)
    }
}

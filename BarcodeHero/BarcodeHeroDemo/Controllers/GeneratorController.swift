//
//  GeneratorController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 10/19/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

import BarcodeHero
import Foundation
import UIKit

class GeneratorController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak var barcodeImageView: UIImageView?
    @IBOutlet weak var dataTextField: UITextField?
    @IBOutlet weak var sizeSlider: UISlider?
    @IBOutlet weak var typeLabel: UILabel?

    @IBOutlet var barcodeImageViewWidthConstraint: NSLayoutConstraint?

    private var data: String = "Example"
    private var type: BHBarcodeType = .qr

    // MARK: - Methods

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        dataTextField?.returnKeyType = .done
        dataTextField?.delegate = self
        dataTextField?.text = data

        let generateBarButtonItem = UIBarButtonItem(title: "Generate", style: .plain, target: self, action: #selector(onGenerateButtonTapped))
        navigationItem.rightBarButtonItem = generateBarButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        regenerateBarcode()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? BarcodeTypesController else {
            return
        }

        controller.delegate = self
        controller.selectedType = type
    }

    // MARK: Actions

    @IBAction func onDataTextFieldEditingChanged(textField: UITextField?) {
        data = textField?.text ?? ""

        regenerateBarcode()
    }

    @IBAction func onSliderValueChanged(slider: UISlider?) {
        guard var sliderValue = slider?.value else {
            return
        }

        if sliderValue < 0.1 {
            sliderValue = 0.1
        } else if sliderValue > 1 {
            sliderValue = 1
        }

        barcodeImageView?.transform = CGAffineTransform(scaleX: CGFloat(sliderValue), y: CGFloat(sliderValue))
    }

    // MARK: Events

    @objc func onGenerateButtonTapped() {
        view.endEditing(true)
        regenerateBarcode()
    }

    // MARK: Utilities

    func regenerateBarcode() {
        guard let image = BHBarcodeGenerator.generate(type: type, text: data)?.transformToFit(barcodeImageView)?.uiImage else {
            return
        }

        barcodeImageView?.image = image
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

        typeLabel?.text = type.rawValue

        regenerateBarcode()

        navigationController?.popToViewController(self, animated: true)
    }
}

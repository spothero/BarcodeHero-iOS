//
//  BHCameraScanController.swift
//  BarcodeHero
//
//  Created by Brian Drelling on 6/8/16.
//  Copyright © 2016 SpotHero. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

open class BHCameraScanController: UIViewController {
    // MARK: - Properties

    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var barcodeDataLabel: UILabel!
    @IBOutlet private var barcodeTypeLabel: UILabel!
    @IBOutlet private var crosshairImageView: UIImageView!
    @IBOutlet private var overlayView: UIView!

    private let session = AVCaptureSession()

//    private var dismissOnScan: Bool = false
    private var hasLoaded: Bool = false
    private var previewLayer: AVCaptureVideoPreviewLayer?
//    private var startingBarTintColor: UIColor?
//    private var startingTintColor: UIColor?

    public weak var delegate: BHCameraScanControllerDelegate?

    // MARK: - Methods

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: Bundle(for: BHCameraScanController.self))
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Overrides

    open override func viewDidLoad() {
        super.viewDidLoad()

        if let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device) {
            try? device.lockForConfiguration()

            if device.isFocusModeSupported(.continuousAutoFocus) {
                device.focusMode = .continuousAutoFocus
            }

            if device.isAutoFocusRangeRestrictionSupported {
                device.autoFocusRangeRestriction = .near
            }

            device.unlockForConfiguration()

            session.addInput(input)
        }

        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes

        previewLayer = AVCaptureVideoPreviewLayer(session: session)

        if let previewLayer = previewLayer {
            view.layer.addSublayer(previewLayer)
        }

        barcodeDataLabel?.text = nil
        barcodeTypeLabel?.text = nil

        session.startRunning()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        startingBarTintColor = navigationController?.navigationBar.barTintColor
//        startingTintColor = navigationController?.navigationBar.tintColor

//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.view.backgroundColor = .clear

        edgesForExtendedLayout = UIRectEdge.all

        session.startRunning()

        barcodeDataLabel?.text = nil
        barcodeTypeLabel?.text = nil
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard !hasLoaded else {
            return
        }

        previewLayer?.frame = view.bounds
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

        if let backgroundView = backgroundView {
            view.bringSubviewToFront(backgroundView)
            backgroundView.alpha = 0
        }

        if let overlayView = overlayView {
            view.bringSubviewToFront(overlayView)
            overlayView.alpha = 0
        }
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !hasLoaded else {
            return
        }

        UIView.animate(withDuration: 0.35) {
            if let crosshairImageView = self.crosshairImageView {
                self.backgroundView?.mask(
                    CGRect(x: crosshairImageView.frame.minX - 10,
                           y: crosshairImageView.frame.minY - 10,
                           width: crosshairImageView.frame.width + 20,
                           height: crosshairImageView.frame.height + 20),
                    invert: true
                )
            }

            self.backgroundView?.alpha = 1
            self.overlayView?.alpha = 1
        }

        hasLoaded = true
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.stopRunning()

        // navigationController?.navigationBar.barTintColor = startingBarTintColor
        // navigationController?.navigationBar.tintColor = startingTintColor
        // navigationController?.navigationBar.isTranslucent = false
    }

    // MARK: - Utilities

    public func stopCapturing() {
        session.stopRunning()
    }

    public func startCapturing() {
        session.startRunning()
    }
}

// MARK: - Classes

public protocol BHCameraScanControllerDelegate: AnyObject {
    func didCapture(metadataObjects: [AVMetadataObject], from controller: BHCameraScanController)
}

// MARK: - Extensions

extension BHCameraScanController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        guard session.isRunning else {
            return
        }

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            barcodeDataLabel?.text = metadataObject.stringValue
            barcodeTypeLabel?.text = String(describing: metadataObject.type.rawValue)
        }

        delegate?.didCapture(metadataObjects: metadataObjects, from: self)
    }
}

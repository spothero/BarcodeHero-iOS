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

public class BHCameraScanController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet private var backgroundView: UIView?
    @IBOutlet private var barcodeDataLabel: UILabel?
    @IBOutlet private var barcodeTypeLabel: UILabel?
    @IBOutlet private var crosshairImageView: UIImageView?
    @IBOutlet private var instructionsLabel: UILabel?
    @IBOutlet private var overlayView: UIView?

    private let session: AVCaptureSession = AVCaptureSession()

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
    
    public override func viewDidLoad() {
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
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        if let previewLayer = previewLayer {
            view.layer.addSublayer(previewLayer)
        }
        
        barcodeDataLabel?.text = nil
        barcodeTypeLabel?.text = nil
        instructionsLabel?.text = nil
        
        session.startRunning()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
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
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard !hasLoaded else {
            return
        }
        
        previewLayer?.frame = view.bounds
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        if let backgroundView = backgroundView {
            view.bringSubview(toFront: backgroundView)
            backgroundView.alpha = 0
        }
        
        if let overlayView = overlayView {
            view.bringSubview(toFront: overlayView)
            overlayView.alpha = 0
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
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
                    invert: true)
            }
            
            self.backgroundView?.alpha = 1
            self.overlayView?.alpha = 1
        }
        
        hasLoaded = true
    }
    
//    public override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        navigationController?.navigationBar.barTintColor = startingBarTintColor
//        navigationController?.navigationBar.tintColor = startingTintColor
//        navigationController?.navigationBar.isTranslucent = false
//    }

    // MARK: Events
    
//    func onBarcodeScanned(_ data: String?, type: HTBarcodeType) {
//        guard let data = data else {
//            return
//        }
//
//        HardwareManager.shared.delegate?.onBarcodeScanned(data, type: type)
//    }

//    // MARK: Static
//
//    static func present(dismissOnScan: Bool) {
//        let controller = CameraScanController()
//        controller.dismissOnScan = dismissOnScan
//
//        controller.openAsModal(withStyle: .overlay)
//    }
//
//    static func show(dismissOnScan: Bool = true) {
//        let controller = CameraScanController()
//        controller.dismissOnScan = dismissOnScan
//
//        UIApplication.shared.visibleViewController?.navigationController?.show(controller, sender: nil)
//    }
}

// MARK: - Classes

public protocol BHCameraScanControllerDelegate: class {
    func didCapture(metadataObjects: [AVMetadataObject])
    func didScanBarcode(ofType type: AVMetadataObject.ObjectType, withData data: String?)
}

// MARK: - Extensions

extension BHCameraScanController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        delegate?.didCapture(metadataObjects: metadataObjects)

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            barcodeDataLabel?.text = metadataObject.stringValue
            barcodeTypeLabel?.text = String(describing: metadataObject.type.rawValue)
        }

//        session.stopRunning()

//        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan, but we only use the first
//        guard let metadata = metadataObjects.first,
//            let metadataObject = metadata as? AVMetadataMachineReadableCodeObject else {
//                return
//        }
////
////        let barcodeData = metadataObject.stringValue
//
//        barcodeDataLabel?.text = metadataObject.stringValue
//        barcodeTypeLabel?.text = String(describing: metadataObject.type.rawValue)

//        instructionsLabel?.isHidden = true
//
//        delegate?.didScanBarcode(ofType: metadataObject.type, withData: metadataObject.stringValue)
//
//        guard dismissOnScan else {
//            return
//        }
//
//        session.stopRunning()
//
////        // NOTE: The top statement in this block might never have fired even with only the first condition
////        if navigationController is ModalNavigationController && navigationController?.viewControllers.first == self {
////            dismiss(animated: true, completion: { [weak self] in
////                self?.onBarcodeScanned(barcodeData, type: barcodeType)
////            })
////        } else {
//            CATransaction.begin()
//            CATransaction.setCompletionBlock({ //[weak self] in
////                self?.onBarcodeScanned(barcodeData, type: barcodeType)
//            })
//
//            _ = navigationController?.popViewController(animated: true)
//
//            CATransaction.commit()
////        }
    }
}

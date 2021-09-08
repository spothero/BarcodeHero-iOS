// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if !os(watchOS) && canImport(UIKit)
    
    import AVFoundation
    import Foundation
    import UIKit
    
    #warning("TODO: Make the controller work well in any orientation.")

    // MARK: - Protocols

    @available(iOS 9.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public protocol BHCameraScanControllerDelegate: AnyObject {
        func didCapture(metadataObjects: [AVMetadataObject], from controller: BHBaseCameraScanController)
    }

    // MARK: - Classes

    @available(iOS 9.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    open class BHBaseCameraScanController: UIViewController {
        fileprivate let session = AVCaptureSession()
        private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        
        fileprivate weak var delegate: BHCameraScanControllerDelegate?
        
        // MARK: Methods - Initializers
        
        public init(delegate: BHCameraScanControllerDelegate) {
            super.init(nibName: nil, bundle: nil)
            
            self.delegate = delegate
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        // MARK: Methods - Lifecycle
        
        override open func viewDidLoad() {
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
                
                self.session.addInput(input)
            }
            
            let output = AVCaptureMetadataOutput()
            self.session.addOutput(output)
            output.metadataObjectTypes = output.availableMetadataObjectTypes
                        
            self.view.layer.addSublayer(self.previewLayer)
            self.previewLayer.frame = view.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
                        
            self.session.startRunning()
        }
        
        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.session.startRunning()
        }
        
        override open func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            self.session.stopRunning()
        }
        
        // MARK: Methods - Utilities
        
        public func stopCapturing() {
            self.session.stopRunning()
        }
        
        public func startCapturing() {
            self.session.startRunning()
        }
        
        public func updateUI(with metadataObjects: [AVMetadataObject]) {
            // Subclasses can override
        }
    }
    
    // MARK: - Extensions

    @available(iOS 9.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    extension BHCameraScanController: AVCaptureMetadataOutputObjectsDelegate {
        public func metadataOutput(_ output: AVCaptureMetadataOutput,
                                   didOutput metadataObjects: [AVMetadataObject],
                                   from connection: AVCaptureConnection) {
            guard self.session.isRunning else {
                return
            }

            self.updateUI(with: metadataObjects)
            
            self.delegate?.didCapture(metadataObjects: metadataObjects, from: self)
        }
    }

#endif

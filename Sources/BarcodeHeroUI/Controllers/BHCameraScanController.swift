// Copyright © 2019 SpotHero, Inc. All rights reserved.

#if canImport(UIKit)

    import AVFoundation
    import Foundation
    import UIKit

    #warning("TODO: Make the controller work well in any orientation.")

    @available(iOS 9.0, *)
    open class BHCameraScanController: UIViewController {
        // MARK: Properties

        private lazy var backgroundView: UIView = {
            let backgroundView = UIView(frame: UIScreen.main.bounds)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.65)

            self.view.addSubview(backgroundView)

            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    backgroundView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                    backgroundView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                    backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                ])
            }

            return backgroundView
        }()

        private lazy var focusAreaView: BHFocusAreaView = {
            let focusAreaView = BHFocusAreaView()

            self.view.addSubview(focusAreaView)

            NSLayoutConstraint.activate([
                focusAreaView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                focusAreaView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])

            return focusAreaView
        }()

        private let session = AVCaptureSession()

//    private var dismissOnScan: Bool = false
        private var hasLoaded: Bool = false
        private var previewLayer: AVCaptureVideoPreviewLayer?
//    private var startingBarTintColor: UIColor?
//    private var startingTintColor: UIColor?

        public weak var delegate: BHCameraScanControllerDelegate?

        // MARK: Methods - Initializers

        public init() {
            super.init(nibName: nil, bundle: nil)
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
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            self.session.addOutput(output)
            output.metadataObjectTypes = output.availableMetadataObjectTypes

            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)

            if let previewLayer = previewLayer {
                view.layer.addSublayer(previewLayer)
            }

            self.focusAreaView.clear()

            self.session.startRunning()
        }

        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

//        startingBarTintColor = navigationController?.navigationBar.barTintColor
//        startingTintColor = navigationController?.navigationBar.tintColor

//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.view.backgroundColor = .clear

            edgesForExtendedLayout = UIRectEdge.all

            self.session.startRunning()

            self.focusAreaView.clear()
        }

        override open func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            guard !self.hasLoaded else {
                return
            }

            self.previewLayer?.frame = view.bounds
            self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

            view.bringSubviewToFront(self.backgroundView)
            self.backgroundView.alpha = 0

            view.bringSubviewToFront(self.focusAreaView)
            self.focusAreaView.alpha = 0
        }

        override open func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            guard !self.hasLoaded else {
                return
            }

            UIView.animate(withDuration: 0.35) {
                let cutoutView = self.focusAreaView.cutoutView
                let cutoutFrame = cutoutView.convert(cutoutView.bounds, to: self.view)

                self.backgroundView.mask(cutoutFrame, invert: true)

                self.backgroundView.alpha = 1
                self.focusAreaView.alpha = 1
            }

            self.hasLoaded = true
        }

        override open func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            self.session.stopRunning()

            // navigationController?.navigationBar.barTintColor = startingBarTintColor
            // navigationController?.navigationBar.tintColor = startingTintColor
            // navigationController?.navigationBar.isTranslucent = false
        }

        // MARK: Methods - Utilities

        public func stopCapturing() {
            self.session.stopRunning()
        }

        public func startCapturing() {
            self.session.startRunning()
        }
    }

    // MARK: - Classes

    @available(iOS 9.0, *)
    public protocol BHCameraScanControllerDelegate: AnyObject {
        func didCapture(metadataObjects: [AVMetadataObject], from controller: BHCameraScanController)
    }

    // MARK: - Extensions

    @available(iOS 9.0, *)
    extension BHCameraScanController: AVCaptureMetadataOutputObjectsDelegate {
        public func metadataOutput(_ output: AVCaptureMetadataOutput,
                                   didOutput metadataObjects: [AVMetadataObject],
                                   from connection: AVCaptureConnection) {
            guard self.session.isRunning else {
                return
            }

            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                self.focusAreaView.barcodeData = metadataObject.stringValue
                self.focusAreaView.barcodeType = String(describing: metadataObject.type.rawValue)
            }

            self.delegate?.didCapture(metadataObjects: metadataObjects, from: self)
        }
    }

#endif

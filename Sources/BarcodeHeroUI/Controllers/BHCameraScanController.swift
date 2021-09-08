// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if !os(watchOS) && canImport(UIKit)
    import AVFoundation
    import Foundation
    import UIKit

    @available(iOS 9.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    open class BHCameraScanController: BHBaseCameraScanController {
        // MARK: Properties

        private lazy var backgroundView: UIView = {
            let backgroundView = UIView(frame: UIScreen.main.bounds)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
            
            self.view.addSubview(backgroundView)
            
            if #available(iOS 11.0, tvOS 11.0, *) {
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
        
        private var hasLoaded = false
    
        // MARK: Methods - Lifecycle
        
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            self.focusAreaView.clear()
        }
        
        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            self.edgesForExtendedLayout = UIRectEdge.all
            self.focusAreaView.clear()
        }
        
        override open func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            guard !self.hasLoaded else {
                return
            }
            
            self.view.bringSubviewToFront(self.backgroundView)
            self.backgroundView.alpha = 0
            
            self.view.bringSubviewToFront(self.focusAreaView)
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
        
        public override func updateUI(with metadataObjects: [AVMetadataObject]) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                self.focusAreaView.barcodeData = metadataObject.stringValue
                self.focusAreaView.barcodeType = String(describing: metadataObject.type.rawValue)
            }
        }
    }
#endif


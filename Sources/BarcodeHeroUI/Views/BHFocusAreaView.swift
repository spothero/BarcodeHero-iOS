// Copyright © 2020 SpotHero, Inc. All rights reserved.

#if !os(watchOS) && canImport(UIKit)
    
    import Foundation
    import UIKit
    
    @available(iOS 9.0, *)
    class BHFocusAreaView: UIView {
        // MARK: Constants
        
        private static let cutoutHeight: CGFloat = 170
        private static let labelHeight: CGFloat = 40
        private static let width: CGFloat = 255
        
        // MARK: Properties - Views
        
        private lazy var barcodeDataLabel: UILabel = {
            let dataLabel = UILabel()
            dataLabel.textAlignment = .center
            dataLabel.translatesAutoresizingMaskIntoConstraints = false
            dataLabel.heightAnchor.constraint(equalToConstant: Self.labelHeight).isActive = true
            
            return dataLabel
        }()
        
        private lazy var barcodeTypeLabel: UILabel = {
            let typeLabel = UILabel()
            typeLabel.textAlignment = .center
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.heightAnchor.constraint(equalToConstant: Self.labelHeight).isActive = true
            
            return typeLabel
        }()
        
        private(set) lazy var cutoutView: UIView = {
            let cutoutView = UIView()
            cutoutView.translatesAutoresizingMaskIntoConstraints = false
            cutoutView.heightAnchor.constraint(equalToConstant: Self.cutoutHeight).isActive = true
            cutoutView.widthAnchor.constraint(equalToConstant: Self.width).isActive = true
            
            return cutoutView
        }()
        
        // MARK: Properties - Convenience
        
        var barcodeData: String? {
            get {
                return self.barcodeDataLabel.text
            }
            set {
                self.barcodeDataLabel.text = newValue
            }
        }
        
        var barcodeType: String? {
            get {
                return self.barcodeTypeLabel.text
            }
            set {
                self.barcodeTypeLabel.text = newValue
            }
        }
        
        // MARK: Methods - Lifecycle
        
        init() {
            super.init(frame: .zero)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 8
            
            stackView.addArrangedSubview(self.barcodeDataLabel)
            stackView.addArrangedSubview(self.cutoutView)
            stackView.addArrangedSubview(self.barcodeTypeLabel)
            
            self.addSubview(stackView)
            
            let totalSpacing = stackView.spacing * CGFloat(stackView.arrangedSubviews.count - 1)
            let height = (Self.labelHeight * 2) + Self.cutoutHeight + totalSpacing
            
            NSLayoutConstraint.activate([
                // Activate height and width constraints for this view
                self.heightAnchor.constraint(equalToConstant: height),
                self.widthAnchor.constraint(equalToConstant: Self.width),
                // Activate pinning constraints for the embedded stack view
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
        
        required convenience init?(coder: NSCoder) {
            self.init()
        }
        
        // MARK: Methods - Utilities
        
        func clear() {
            self.barcodeData = nil
            self.barcodeType = nil
        }
    }
    
#endif

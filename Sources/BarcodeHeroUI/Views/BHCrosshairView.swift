// Copyright © 2019 SpotHero, Inc. All rights reserved.

#if canImport(UIKit)

    import Foundation
    import UIKit

    @available(iOS 9.0, *)
    public class BHCrosshairView: UIView {
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

        public private(set) lazy var cutoutView: UIView = {
            let cutoutView = UIView()
            cutoutView.translatesAutoresizingMaskIntoConstraints = false
            cutoutView.heightAnchor.constraint(equalToConstant: Self.cutoutHeight).isActive = true
            cutoutView.widthAnchor.constraint(equalToConstant: Self.width).isActive = true

            return cutoutView
        }()

        // MARK: Properties - Convenience

        public var barcodeData: String? {
            get {
                return self.barcodeDataLabel.text
            }
            set {
                self.barcodeDataLabel.text = newValue
            }
        }

        public var barcodeType: String? {
            get {
                return self.barcodeTypeLabel.text
            }
            set {
                self.barcodeTypeLabel.text = newValue
            }
        }

        // MARK: Methods - Lifecycle

        override public func layoutSubviews() {
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

            // Activate height and width constraints for this view
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: height),
                self.widthAnchor.constraint(equalToConstant: Self.width),
            ])

            // Activate pinning constraints for the embedded stack view
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }

        // MARK: Methods - Utilities

        public func clear() {
            self.barcodeData = nil
            self.barcodeType = nil
        }
    }

#endif

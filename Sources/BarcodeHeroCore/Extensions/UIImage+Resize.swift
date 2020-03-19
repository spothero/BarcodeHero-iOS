// Copyright © 2020 SpotHero, Inc. All rights reserved.

#if canImport(UIKit) && !os(watchOS)

    import Foundation
    import UIKit

    extension UIImage {
        /// Resizes an image based on the size and contentMode of the passed in imageView
        /// - Parameter imageView: The imageView whose size and contentMode should be referenced
        public func bh_resizedTo(_ imageView: UIImageView) throws -> UIImage? {
            return try self.bh_resizedTo(imageView.bounds.size, forContentMode: imageView.contentMode)
        }

        public func bh_resizedTo(_ size: CGSize, forContentMode contentMode: UIView.ContentMode? = nil) throws -> UIImage? {
            if let ciImage = self.ciImage {
                #if os(tvOS) || os(watchOS)
                    return nil
                #else
                    return ciImage.transformedToFit(size)?.uiImage
                #endif
            } else if let cgImage = self.cgImage {
                let contentMode = contentMode ?? .scaleAspectFit
                return try BHImageHelper.resize(cgImage, toSize: size, forContentMode: contentMode).uiImage
            } else {
                // TODO: Throw error
                return nil
            }
        }
    }

#endif

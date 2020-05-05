// Copyright © 2020 SpotHero, Inc. All rights reserved.

import AVFoundation
import Foundation

#if canImport(CoreImage)
    import CoreImage
#endif

#if canImport(UIKit)
    import UIKit
#endif

class BHImageHelper {
    /// The default top spacing of the CIImage generated AVMetadataObjectTypePDF417Code type image
    private static let topSpacing: CGFloat = 0
    
    /// The default top spacing of the CIImage generated AVMetadataObjectTypePDF417Code type image
    private static let bottomSpacing: CGFloat = 0
    
    /// The default height of the CIImage generated AVMetadataObjectTypePDF417Code type image
    private static let height: CGFloat = 28
    
    /// The default line width for a 1D barcode
    private static let lineWidth: CGFloat = 1
    
    // TODO: For now, we're not use Quiet Zone spacing and we're expecting the client to adjust padding on their own
    /// The spacing to provide to the quiet zone all around
    /// For 1D barcodes, this should be 10 times the width of the narrowest bar or 1/8 inch, whichever is greater
    private static let quietZoneSpacing: CGFloat = 0 // Self.lineWidth * 10
    
    static func draw(_ data: String, options: BHBarcodeOptions? = nil) throws -> CGImage? {
        guard !data.isEmpty else {
            throw BHError.dataRequired
        }
        
        let options = options ?? BHBarcodeOptions()
        
        let size = CGSize(width: CGFloat(data.count) + (Self.quietZoneSpacing * 2), height: Self.height)
        
        guard let context = CGContext.from(size: size) else {
            throw BHError.couldNotGetGraphicsContext
        }
        
        context.setShouldAntialias(false)
        
        if let fillColor = options.fillColor {
            context.setFillColor(fillColor)
        }
        
        if let strokeColor = options.strokeColor {
            context.setStrokeColor(strokeColor)
        }
        
        context.fill(CGRect(origin: .zero, size: size))
        context.setLineWidth(Self.lineWidth)
        
        for index in 0 ..< data.count {
            // 1 implies that nothing is drawn ("quiet zone")
            guard data[index] == "1" else {
                continue
            }
            
            let x = CGFloat(index) + (Self.quietZoneSpacing + 1)
            context.move(to: CGPoint(x: x, y: Self.topSpacing))
            context.addLine(to: CGPoint(x: x, y: size.height - Self.bottomSpacing))
        }
        
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        return context.makeImage()
    }
    
    static func resize(_ image: CGImage, scale: CGFloat) throws -> CGImage? {
        let width = CGFloat(image.width) * scale
        let height = CGFloat(image.height) * scale
        let size = CGSize(width: width, height: height)
        
        guard let context = CGContext.from(size: size) else {
            throw BHError.couldNotGetGraphicsContext
        }
        
        context.interpolationQuality = CGInterpolationQuality.none
        
        context.draw(image, in: CGRect(origin: .zero, size: size))
        
        return context.makeImage()
    }
}

// MARK: - Extensions

// MARK: BHImageHelper

#if canImport(UIKit) && !os(watchOS)
    
    extension BHImageHelper {
        static func resize(_ image: CGImage,
                           toSize targetSize: CGSize,
                           forContentMode contentMode: UIView.ContentMode = .scaleAspectFit) throws -> CGImage {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var width = targetSize.width
            var height = targetSize.height
            
            switch contentMode {
            case .scaleToFill:
                // do nothing
                break
            case .scaleAspectFill:
                // contents scaled to fill with fixed aspect. some portion of content may be clipped.
                let targetLength = (targetSize.height > targetSize.width) ? targetSize.height : targetSize.width
                let sourceLength = (image.height < image.width) ? image.height : image.width
                let fillScale = targetLength / CGFloat(sourceLength)
                width = CGFloat(image.width) * fillScale
                height = CGFloat(image.height) * fillScale
                x = (targetSize.width - width) / 2.0
                y = (targetSize.height - height) / 2.0
            default:
                let scaledRect = AVMakeRect(aspectRatio: CGSize(width: image.width, height: image.height),
                                            insideRect: CGRect(x: 0.0, y: 0.0, width: targetSize.width, height: targetSize.height))
                
                width = scaledRect.width
                height = scaledRect.height
                
                switch contentMode {
                case .scaleAspectFit, .redraw, .center:
                    x = (targetSize.width - width) / 2.0
                    y = (targetSize.height - height) / 2.0
                case .top:
                    x = (targetSize.width - width) / 2.0
                    y = 0
                case .bottom:
                    x = (targetSize.width - width) / 2.0
                    y = targetSize.height - height
                case .left:
                    x = 0
                    y = (targetSize.height - height) / 2.0
                case .right:
                    x = targetSize.width - width
                    y = (targetSize.height - height) / 2.0
                case .topLeft:
                    x = 0
                    y = 0
                case .topRight:
                    x = targetSize.width - width
                    y = 0
                case .bottomLeft:
                    x = 0
                    y = targetSize.height - height
                case .bottomRight:
                    x = targetSize.width - width
                    y = targetSize.height - height
                default:
                    break
                }
            }
            
            guard let context = CGContext.from(size: targetSize) else {
                throw BHError.couldNotGetGraphicsContext
            }
            
            context.interpolationQuality = CGInterpolationQuality.none
            
            // this puts the origin of the coordinate system into the top-left for drawing,
            // which makes 2D codes orient properly when drawn
            context.translateBy(x: 0, y: height)
            context.scaleBy(x: 1, y: -1)
            
            context.draw(image, in: CGRect(x: x, y: y, width: width, height: height))
            
            guard let contextImage = context.makeImage() else {
                throw BHError.couldNotCreateImageFromContext
            }
            
            return contextImage
        }
    }
    
#endif

// MARK: CGContext

private extension CGContext {
    static func from(width: Int, height: Int) -> CGContext? {
        return self.from(size: CGSize(width: width, height: height))
    }
    
    static func from(size: CGSize) -> CGContext? {
        guard size.width > 0, size.height > 0 else {
            return nil
        }
        
        var context: CGContext?
        
        // If we can import UIKit, attempt to create the CGContext from the current UIGraphics context
        #if canImport(UIKit)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            
            context = UIGraphicsGetCurrentContext()
        #endif
        
        // If context is nil, either because UIKit could not be imported or the UIGraphics context failed, create it
        if context == nil {
            context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        }
        
        return context
    }
}

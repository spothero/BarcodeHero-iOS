// Copyright © 2021 SpotHero, Inc. All rights reserved.

#if canImport(CoreImage)
    import CoreImage
    import Foundation
    
    /// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPDF417BarcodeGenerator
    public struct BHPDF417FilterParameters: BHFilterParameterizable {
        public var inputAlwaysSpecifyCompaction: NSNumber
        public var inputCompactionMode: NSNumber
        public var inputCompactStyle: NSNumber
        public var inputCorrectionLevel: NSNumber
        public var inputDataColumns: NSNumber
        public var inputDataRows: NSNumber
        public var inputMaxHeight: NSNumber
        public var inputMaxWidth: NSNumber
        public var inputMinHeight: NSNumber
        public var inputMinWidth: NSNumber
        public var inputPreferredAspectRatio: NSNumber
        
        public func loadInto(_ filter: CIFilter) {
            filter.setValuesForKeys([
                BHPDF417FilterParameterKey.inputAlwaysSpecifyCompaction.rawValue: self.inputAlwaysSpecifyCompaction,
                BHPDF417FilterParameterKey.inputCompactionMode.rawValue: self.inputCompactionMode,
                BHPDF417FilterParameterKey.inputCompactStyle.rawValue: self.inputCompactStyle,
                BHPDF417FilterParameterKey.inputCorrectionLevel.rawValue: self.inputCorrectionLevel,
                BHPDF417FilterParameterKey.inputDataColumns.rawValue: self.inputDataColumns,
                BHPDF417FilterParameterKey.inputDataRows.rawValue: self.inputDataRows,
                BHPDF417FilterParameterKey.inputMaxHeight.rawValue: self.inputMaxHeight,
                BHPDF417FilterParameterKey.inputMaxWidth.rawValue: self.inputMaxWidth,
                BHPDF417FilterParameterKey.inputMinHeight.rawValue: self.inputMinHeight,
                BHPDF417FilterParameterKey.inputMinWidth.rawValue: self.inputMinWidth,
                BHPDF417FilterParameterKey.inputPreferredAspectRatio.rawValue: self.inputPreferredAspectRatio,
            ])
        }
    }
    
#endif

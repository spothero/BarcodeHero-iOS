// Copyright © 2019 SpotHero, Inc. All rights reserved.

#if canImport(SwiftUI) && canImport(UIKit)

    import SwiftUI

    @available(iOS 13.0, *)
    public struct BHCameraScanView: View {
        public var body: some View {
            BHCameraScanController()
        }

        public init() {}
    }

    @available(iOS 13.0, *)
    public struct BHCameraScanView_Previews: PreviewProvider {
        public static var previews: some View {
            BHCameraScanView()
        }
    }

#endif

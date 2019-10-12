// Copyright © 2019 SpotHero, Inc. All rights reserved.

import BarcodeHeroUI
import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("GENERATING")) {
                    NavigationLink(destination: GeneratorView()) {
                        Text("Generator")
                    }
                    NavigationLink(destination: MultiGeneratorView()) {
                        Text("Multi-Generator (Incomplete)")
                    }
                }

                Section(header: Text("SCANNING")) {
                    NavigationLink(destination: BHCameraScanView()) {
                        Text("Reader")
                    }

//                    NavigationLink(destination: BHCameraScanView()) {
//                        Text("Reader with Delegation")
//                    }
                }
            }
            .navigationBarTitle("BarcodeHero Demo")
            .listStyle(GroupedListStyle())
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

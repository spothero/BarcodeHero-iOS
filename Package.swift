// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BarcodeHero",
    dependencies: [
      .package(url: "https://github.com/danger/swift.git", from: "1.4.0"),
      .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"),
    ],
    targets: [
        // This is just an arbitrary Swift file in our app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(name: "BarcodeHero", dependencies: ["Danger"], path: "BarcodeHero/BarcodeHero", sources: ["SPMWorkaround.swift"]),
    ]
)

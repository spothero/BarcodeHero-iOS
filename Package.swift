// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BarcodeHero",
    dependencies: [
      .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.40.8"),
      .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0"),
      .package(url: "https://github.com/spothero/Zinc", from: "0.1.0"),
    ]
)

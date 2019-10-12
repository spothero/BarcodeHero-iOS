// swift-tools-version:5.1

// Copyright © 2019 SpotHero, Inc. All rights reserved.

import PackageDescription

let package = Package(
    name: "BarcodeHero",
    platforms: [
        .iOS(.v8),          // minimum supported version via SPM
        .macOS(.v10_15),    // supports AVMetaDataObject.ObjectType barcode and QR code types
        // tvOS is unsupported due to lack of AVMetadataObject support
        // watchOS is unsupported due to lack of CoreImage support
    ],
    products: [
        .library(name: "BarcodeHero", targets: ["BarcodeHeroCore", "BarcodeHeroUI"]),
        .library(name: "BarcodeHeroCore", targets: ["BarcodeHeroCore"]),
        .library(name: "BarcodeHeroUI", targets: ["BarcodeHeroUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BarcodeHeroCore",
            dependencies: []
        ),
        .target(
            name: "BarcodeHeroUI",
            dependencies: []
        ),
        .testTarget(
            name: "BarcodeHeroCoreTests",
            dependencies: [
                .target(name: "BarcodeHeroCore"),
            ]
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)

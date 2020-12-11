// swift-tools-version:5.1

// Copyright © 2019 SpotHero, Inc. All rights reserved.

import PackageDescription

let package = Package(
    name: "BarcodeHero",
    platforms: [
        .iOS(.v9),          // minimum supported version for Xcode 12
        .macOS(.v10_15),    // supports AVMetaDataObject.ObjectType barcode and QR code types
        // tvOS is unsupported due to lack of AVMetadataObject support
        // watchOS is unsupported due to lack of CoreImage support
    ],
    products: [
        .library(name: "BarcodeHero", targets: ["BarcodeHeroCore", "BarcodeHeroUI"]),
        .library(name: "BarcodeHeroCore", targets: ["BarcodeHeroCore"]),
        .library(name: "BarcodeHeroUI", targets: ["BarcodeHeroUI"]),
        // Dynamic Libraries
        // These libraries are required due to the Xcode 11.3+ static linking bug: https://bugs.swift.org/browse/SR-12303
        .library(name: "BarcodeHeroDynamic", type: .dynamic, targets: ["BarcodeHeroCore", "BarcodeHeroUI"]),
        .library(name: "BarcodeHeroCoreDynamic", type: .dynamic, targets: ["BarcodeHeroCore"]),
        .library(name: "BarcodeHeroUIDynamic", type: .dynamic, targets: ["BarcodeHeroUI"]),
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

// swift-tools-version:5.1

// Copyright © 2019 SpotHero, Inc. All rights reserved.

import PackageDescription

// NOTE: BarcodeHeroUI is not yet supported! We're lacking the ability to include Resources in SPM projects.
//       When this is possible, we need to address all BLOCKED BY SR-2866 sections below
//       Reference: https://bugs.swift.org/browse/SR-2866

let package = Package(
    name: "BarcodeHero",
    platforms: [
        .iOS(.v8),          // minimum supported version via SPM
        .macOS(.v10_15),    // supports AVMetaDataObject.ObjectType barcode and QR code types
        // tvOS is unsupported due to lack of AVMetadataObject support
        // watchOS is unsupported due to lack of CoreImage support
    ],
    products: [
        .library(name: "BarcodeHeroCore", targets: ["BarcodeHeroCore"]),
        // BLOCKED BY SR-2866 -- Uncomment
        // .library(name: "BarcodeHeroUI", targets: ["BarcodeHeroUI"]),
        .library(name: "BarcodeHero", targets: ["BarcodeHeroCore"]),
        // BLOCKED BY SR-2866 -- Uncomment and delete the previous definition of the BarcodeHero library product
        // .library(name: "BarcodeHero", targets: ["BarcodeHeroCore", "BarcodeHeroUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BarcodeHeroCore",
            dependencies: []
        ),
        // BLOCKED BY SR-2866 -- Uncomment
        // .target(
        //     name: "BarcodeHeroUI",
        //     dependencies: []
        // ),
        .testTarget(
            name: "BarcodeHeroCoreTests",
            dependencies: [
                .target(name: "BarcodeHeroCore"),
            ]
        ),
        // BLOCKED BY SR-2866 -- Uncomment
        // .testTarget(
        //     name: "BarcodeHeroUITests",
        //     dependencies: [
        //         .target(name: "BarcodeHeroUI"),
        //     ]
        // ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)

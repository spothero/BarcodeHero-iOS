// swift-tools-version:5.1

import PackageDescription

// NOTE: BarcodeHeroUI is not yet supported! We're lacking the ability to include Resources in SPM projects.
//       When this is possible, we need to address all BLOCKED BY SR-2866 sections below
//       Reference: https://bugs.swift.org/browse/SR-2866

let package = Package(
    name: "BarcodeHero",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
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
    ]
)

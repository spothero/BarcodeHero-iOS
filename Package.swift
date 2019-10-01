// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "BarcodeHero",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "BarcodeHeroCore", targets: ["BarcodeHeroCore"]),
        .library(name: "BarcodeHeroUI", targets: ["BarcodeHeroUI"]),
        .library(name: "BarcodeHero", targets: ["BarcodeHeroCore", "BarcodeHeroUI"]),
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
            name: "BarcodeHeroTests",
            dependencies: [
                .target(name: "BarcodeHeroCore"),
                .target(name: "BarcodeHeroUI"),
            ]
        ),
    ]
)

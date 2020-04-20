# BarcodeHero

BarcodeHero is a library that allows you to generate and scan barcodes.

- [Features](#features)
- [Formats](#formats)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Communication](#communication)

## Features

- [x] Generates images for numerous barcode types.
- [x] Validates barcode data prior to generation.
- [x] Handles errors with ease. (Nearly every method is marked with `throws` and errors are clear and concise.)
- [x] Separates subspecs by function so you only take what you need.
- [ ] Contains a camera scan controller for easy implementation into your own app. (In the UI subspec only!)

## Formats

#### Supported

- [x] Aztec (native)
- [x] Code 39
- [x] Code 39 mod 43
- [x] Code 128 (native)
- [x] EAN-8
- [x] EAN-13 (ISBN-13, ISSN-13)
- [x] Interleaved 2 of 5
- [x] ITF-14
- [x] PDF417 (native)
- [x] QR (native)
- [x] UPC-E

#### Unsupported

- [ ] Codabar
- [ ] Code 39 Extended
- [ ] Data Matrix
- [ ] MaxiCode
- [ ] RSS-14
- [ ] RSS-Expanded
- [ ] UPC-A

## Requirements

- iOS 10.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### Swift Package Manager

(Swift Package Manager](https://swift.org/package-manager/) is built into the Swift toolchain and is our preferred way of integrating the SDK.

For Swift package projects, simply add the following line to your `Package.swift` file in the `dependencies` section:

```swift
dependencies: [
  .package(url: "https://github.com/spothero/BarcodeHero-iOS", .upToNextMajor(from: "0.5.0")),
]
```

For app projects, simply follow the [Apple documentation](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) on adding package dependencies to your app.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. 

We no longer support CocoaPods for versions later then `0.5.0`. If you require CocoaPods support, please open an issue. 

## Usage

You can easily generate a barcode by doing the following:

```Swift
let image = try BHBarcodeGenerator.generate(.qr, withData: "Example")
```

There are also extensions for resizing the barcode to a `CGSize` or `UIImageView` without aliasing or blur:

```Swift
try image.resizeTo(barcodeImageView)
try image.resizeTo(CGSize(width: 100, height: 20), forContentMode: .scaleAspectFit)
```

## Communication

For all bugs, feature requests, and communication, please open an issue for the time being.

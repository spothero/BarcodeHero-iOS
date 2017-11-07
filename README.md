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

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

BarcodeHero can be added to your project by adding the following line to your Podfile:

```Ruby
pod 'BarcodeHero', '~> 0.1'
```

For convenience, BarcodeHero is broken up into separate subspecs depending on functionality. 

- `Core` is for barcode generation. It is included by default.
- `UI` is for barcode scanning. It is dependent on the `Core` subspec.

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

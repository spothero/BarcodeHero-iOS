//
//  BarcodeHeroTests.swift
//  BarcodeHeroTests
//
//  Created by Brian Drelling on 11/6/17.
//  Copyright © 2017 SpotHero. All rights reserved.
//

@testable import BarcodeHero
import XCTest

class BarcodeHeroTests: XCTestCase {
    var testData: [(String, [BHBarcodeType])] = [
        ("Example", [.qr])
    ]

    override func setUp() {
        super.setUp()

        continueAfterFailure = true
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testNoThrow() {
        let data = "Example"

        for type in BHBarcodeType.asArray {
            do {
                    let image = try BHBarcodeGenerator.generate(type, withData: "Example")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}

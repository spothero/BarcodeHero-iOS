// Copyright © 2020 SpotHero, Inc. All rights reserved.

@testable import BarcodeHeroCore
import XCTest

class BarcodeHeroCoreTests: XCTestCase {
    var testData: [(String, [BHBarcodeType])] = [("Example", [.qr])]
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = true
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNoThrow() {
        for type in BHBarcodeType.allCases {
            do {
                switch type {
                case .code39,
                     .code39Mod43:
                    return
                default:
                    _ = try BHBarcodeGenerator.generate(type, withData: "Example")
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}

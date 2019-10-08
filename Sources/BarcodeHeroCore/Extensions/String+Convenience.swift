// Copyright © 2019 SpotHero, Inc. All rights reserved.

import Foundation

// swiftlint:disable identifier_name
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }

    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }

    func indexDistance(of character: Character) throws -> Int {
        guard let index = firstIndex(of: character) else {
            throw BHError.indexOutOfBounds
        }

        return distance(from: startIndex, to: index)
    }

    func indexDistance(of character: String) throws -> Int {
        return try self.indexDistance(of: character[startIndex])
    }

    func substring(_ i: Int, length: Int) throws -> String {
        guard i + length <= count else {
            throw BHError.indexOutOfBounds
        }

        return self[i ..< i + length]
    }
}

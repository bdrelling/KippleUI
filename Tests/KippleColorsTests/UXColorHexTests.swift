// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleColors
import SwiftUI
import XCTest

final class UXColorHexTests: XCTestCase {
    func testHexProperty() {
        // Given
        let color: UXColor = .systemRed // Red color
        let expectedHexString = "FF453A" // Hexadecimal representation of red color

        // When
        let hexString = color.hex

        // Then
        XCTAssertEqual(hexString, expectedHexString)
    }

    func testHexInitWithValidHexString() {
        // Given
        let hexString = "FF0000" // Red color
        let expectedColor: UXColor = .init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)

        // When
        let color: UXColor = .init(hex: hexString)

        // Then
        XCTAssertEqual(color, expectedColor)
    }

    func testHexInitWithInvalidHexString() {
        // Given
        let hexString = "InvalidHexString" // Invalid hex string
        let expectedColor: UXColor = .init(red: 0, green: 0, blue: 0, alpha: 1.0) // Expected to default to black color

        // When
        let color: UXColor = .init(hex: hexString)

        // Then
        XCTAssertEqual(color, expectedColor)
    }

    func testHexInitWithValidHexValue() {
        // Given
        let hexValue: UInt = 0xFF0000 // Red color
        let expectedColor: UXColor = .init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)

        // When
        let color: UXColor = .init(hex: hexValue)

        // Then
        XCTAssertEqual(color, expectedColor)
    }
}

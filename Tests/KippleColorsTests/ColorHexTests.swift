// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleColors
import SwiftUI
import XCTest

final class ColorHexTests: XCTestCase {
    func testHexProperty() {
        // Given
        let color: Color = .red // Red color
        let expectedHexString = "FF453A" // Hexadecimal representation of red color

        // When
        let hexString = color.hex

        // Then
        XCTAssertEqual(hexString, expectedHexString)
    }

    func testHexInitWithValidHexString() {
        // Given
        let hexString = "FF0000" // Red color
        let expectedColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)

        // When
        let color = Color(hex: hexString)

        // Then
        XCTAssertEqual(color, expectedColor)
    }

    func testHexInitWithInvalidHexString() {
        // Given
        let hexString = "InvalidHexString" // Invalid hex string
        let expectedColor = Color.black // Expected to default to black color

        // When
        let color = Color(hex: hexString)

        // Then
        XCTAssertEqual(color, expectedColor)
    }

    func testHexInitWithValidHexValue() {
        // Given
        let hexValue: UInt = 0xFF0000 // Red color
        let expectedColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)

        // When
        let color = Color(hex: hexValue)

        // Then
        XCTAssertEqual(color, expectedColor)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleColors
import SwiftUI
import XCTest

final class ColorAdjustedTests: XCTestCase {
    func testLighterColor() {
        // Given
        let color = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0) // Gray color
        let percentage: CGFloat = 20 // 20% lighter

        // When
        let lighterColor = color.lighter(byPercentage: percentage)

        // Then
        XCTAssertEqual(color.hex, "808080")
        XCTAssertEqual(lighterColor.hex, "B3B3B3")
    }

    func testDarkerColor() {
        // Given
        let color = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0) // Gray color
        let percentage: CGFloat = 20 // 20% darker

        // When
        let darkerColor = color.darker(byPercentage: percentage)

        // Then
        XCTAssertEqual(color.hex, "808080")
        XCTAssertEqual(darkerColor.hex, "4D4D4D")
    }

    func testAdjustedColor() {
        // Given
        let color = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0) // Gray color
        let percentage: CGFloat = 20 // 20% adjustment

        // When
        let lighterColor = color.adjusted(byPercentage: percentage)
        let darkerColor = color.adjusted(byPercentage: -percentage)

        // Then
        XCTAssertEqual(color.hex, "808080")
        XCTAssertEqual(lighterColor.hex, "B3B3B3")
        XCTAssertEqual(darkerColor.hex, "4D4D4D")
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleFonts
import SwiftUI
import XCTest

final class KippleFontsTests: XCTestCase {
    func testAvailableFontFamilies() {
        XCTAssertGreaterThan(Font.allFonts.count, 0)
        XCTAssertGreaterThan(FontManager.shared.availableFontFamilies.count, 0)
    }

    func testAvailableFontFamiliesAndVariations() {
        XCTAssertGreaterThan(Font.allFontsAndVariations.count, 0)
        XCTAssertGreaterThan(FontManager.shared.availableFontFamiliesAndVariations.count, 0)
    }
}

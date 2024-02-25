// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleFont
import SwiftUI
import XCTest

final class KippleFontTests: XCTestCase {
    func testAvailableFontFamilies() {
        #if os(macOS)
        XCTAssertEqual(Font.allFonts.count, 225)
        XCTAssertEqual(FontManager.shared.availableFontFamilies.count, 225)
        #else
        XCTAssertEqual(Font.allFonts.count, 84)
        XCTAssertEqual(FontManager.shared.availableFontFamilies.count, 84)
        #endif
    }

    func testAvailableFonts() {
        #if os(macOS)
        XCTAssertEqual(Font.allFontsAndVariations.count, 773)
        XCTAssertEqual(FontManager.shared.availableFontFamiliesAndVariations.count, 773)
        #else
        XCTAssertEqual(Font.allFontsAndVariations.count, 284)
        XCTAssertEqual(FontManager.shared.availableFontFamiliesAndVariations.count, 284)
        #endif
    }
}

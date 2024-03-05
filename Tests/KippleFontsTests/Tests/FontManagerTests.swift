// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleFonts
import SwiftUI
import XCTest

final class FontManagerTests: XCTestCase {
    func testFontAvailability() {
        XCTAssertFalse(FontManager.shared.availableFontFamilies.isEmpty)
        XCTAssertFalse(FontManager.shared.availableFontFamiliesAndVariations.isEmpty)
        XCTAssertFalse(FontManager.shared.availableFonts.isEmpty)
        XCTAssertFalse(FontManager.shared.availableFontsAndVariations.isEmpty)
    }

    func testFontRegistration() throws {
        let bundleIdentifier = try XCTUnwrap(Bundle.module.bundleIdentifier)
        try XCTAssertFalse(FontManager.shared.hasRegistered(bundleIdentifier))
        try FontManager.shared.registerFonts(in: .module)
        try XCTAssertTrue(FontManager.shared.hasRegistered(bundleIdentifier))
    }
}

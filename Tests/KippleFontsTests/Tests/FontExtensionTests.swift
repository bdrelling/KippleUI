// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleFonts
import SwiftUI
import XCTest

final class FontExtensionTests: XCTestCase {
    func testFontAvailability() {
        XCTAssertFalse(Font.familyNames.isEmpty)
        XCTAssertFalse(UXFont.familyNames.isEmpty)

        XCTAssertFalse(Font.familyNamesAndVariations.isEmpty)
        XCTAssertFalse(UXFont.familyNamesAndVariations.isEmpty)

        XCTAssertFalse(Font.allFonts.isEmpty)
        XCTAssertFalse(UXFont.allFonts.isEmpty)

        XCTAssertFalse(Font.allFontsAndVariations.isEmpty)
        XCTAssertFalse(UXFont.allFontsAndVariations.isEmpty)
    }

    func testPreferredUXFontMethod() {
        let preferredFont = Font.preferredUXFont(forTextStyle: .body)
//        XCTAssertEqual(preferredFont, .init())
    }

//        func testPrintNamesMethod() {
//            // Capture the output printed to the console
//            let capturedOutput = CapturingIO {
//                Font.printNames()
//            }
//            XCTAssertTrue(capturedOutput.contains("printedNames"), "Names should be printed to the console")
//        }
//
//        func testPrintNamesAndVariationsMethod() {
//            // Capture the output printed to the console
//            let capturedOutput = CapturingIO {
//                Font.printNamesAndVariations()
//            }
//            XCTAssertTrue(capturedOutput.contains("printedNamesAndVariations"), "Names and variations should be printed to the console")
//        }
}

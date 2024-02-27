// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font {
    static var familyNames: [String] {
        UXFont.familyNames
    }

    static var familyNamesAndVariations: [String] {
        UXFont.familyNamesAndVariations
    }

    static var allFonts: [Font] {
        familyNames
            .compactMap { Font.custom($0, relativeTo: .body) }
    }

    static var allFontsAndVariations: [Font] {
        familyNamesAndVariations
            .compactMap { Font.custom($0, relativeTo: .body) }
    }

    static func preferredUXFont(forTextStyle textStyle: Font.TextStyle) -> UXFont {
        UXFont.preferredFont(forTextStyle: textStyle.uxTextStyle)
    }

    static func printNames() {
        UXFont.printNames()
    }

    static func printNamesAndVariations() {
        UXFont.printNamesAndVariations()
    }
}

public extension UXFont {
    static var allFonts: [UXFont] {
        familyNames
            .sorted()
            .compactMap { .init(name: $0, relativeTo: .body) }
    }

    static var allFontsAndVariations: [UXFont] {
        familyNamesAndVariations
            .sorted()
            .compactMap { .init(name: $0, relativeTo: .body) }
    }

    static func printNames() {
        familyNames.forEach { print($0) }
    }

    static func printNamesAndVariations() {
        familyNamesAndVariations.forEach { print($0) }
    }
}

// MARK: - Platform Conformance

#if canImport(UIKit)

public typealias UXFont = UIFont

public extension UIFont {
    convenience init?(name: String, relativeTo textStyle: TextStyle) {
        self.init(name: name, size: textStyle.preferredSize)
    }

    static var familyNamesAndVariations: [String] {
        UIFont.familyNames
            .flatMap(UIFont.fontNames)
            .sorted()
    }
}

#elseif canImport(AppKit)

public typealias UXFont = NSFont

public extension NSFont {
    convenience init?(name: String, relativeTo textStyle: TextStyle) {
        self.init(name: name, size: textStyle.preferredSize)
    }

    static var familyNames: [String] {
        NSFontManager.shared.availableFontFamilies
            .sorted()
    }

    static var familyNamesAndVariations: [String] {
        NSFontManager.shared.availableFonts
            .sorted()
    }
}

#endif

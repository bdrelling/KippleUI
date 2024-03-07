// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Extension to provide convenience methods for working with fonts.
public extension Font {
    /// An array of all available font family names.
    static var familyNames: [String] {
        UXFont.familyNames
    }

    /// An array of all available font family names along with their variations.
    static var familyNamesAndVariations: [String] {
        UXFont.familyNamesAndVariations
    }

    /// An array of all available fonts.
    static var allFonts: [Font] {
        UXFont.allFonts.map(Font.init)
    }

    /// An array of all available fonts along with their variations.
    static var allFontsAndVariations: [Font] {
        UXFont.allFontsAndVariations.map(Font.init)
    }

    /// Retrieves the preferred system font for the specified text style.
    ///
    /// - Parameter textStyle: The text style for which to retrieve the preferred font.
    /// - Returns: The preferred system font for the specified text style.
    static func preferredUXFont(forTextStyle textStyle: Font.TextStyle) -> UXFont {
        UXFont.preferredFont(forTextStyle: textStyle.uxTextStyle)
    }

    /// Prints all available font family names to the console.
    static func printNames() {
        UXFont.printNames()
    }

    /// Prints all available font family names along with their variations to the console.
    static func printNamesAndVariations() {
        UXFont.printNamesAndVariations()
    }
}

// MARK: - UIKit / AppKit Extensions

public extension UXFont {
    /// An array of all available fonts.
    static var allFonts: [UXFont] {
        familyNames
            .sorted()
            .compactMap { UXFont(name: $0, relativeTo: .body) }
    }

    /// An array of all available font family names along with their variations.
    static var allFontsAndVariations: [UXFont] {
        familyNamesAndVariations
            .sorted()
            .compactMap { UXFont(name: $0, relativeTo: .body) }
    }

    /// A wrapper around `familyName` that converts to a `String` on all platforms.
    ///
    /// This is necessary because `NSFont.familyName` is optional, but `UIFont.familyName` is not.
    /// On macOS, if a family name is not found, a value of `"Unknown"` is returned.
    var safeFamilyName: String {
        #if canImport(UIKit)
        self.familyName
        #else
        self.familyName ?? "Unknown"
        #endif
    }

    /// Prints all available font family names to the console.
    static func printNames() {
        familyNames.forEach { print($0) }
    }

    /// Prints all available font family names along with their variations to the console.
    static func printNamesAndVariations() {
        familyNamesAndVariations.forEach { print($0) }
    }
}

// MARK: - UIKit / AppKit Extensions

#if canImport(UIKit)

public extension UIFont {
    /// An array of all available font family names along with their variations.
    static var familyNamesAndVariations: [String] {
        UIFont.familyNames
            .flatMap(UIFont.fontNames)
            .sorted()
    }

    /// Initializes a font with the specified name relative to a text style.
    convenience init?(name: String, relativeTo textStyle: TextStyle) {
        self.init(name: name, size: textStyle.preferredSize)
    }
}

#elseif canImport(AppKit)

public extension NSFont {
    /// An array of all available font family names.
    static var familyNames: [String] {
        NSFontManager.shared.availableFontFamilies
            .sorted()
    }

    /// An array of all available font family names along with their variations.
    static var familyNamesAndVariations: [String] {
        NSFontManager.shared.availableFonts
            .sorted()
    }

    /// Initializes a font with the specified name relative to a text style.
    convenience init?(name: String, relativeTo textStyle: TextStyle) {
        self.init(name: name, size: textStyle.preferredSize)
    }
}

#endif

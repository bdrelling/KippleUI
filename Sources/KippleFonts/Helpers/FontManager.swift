// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public final class FontManager {
    // MARK: Shared Instance

    public static let shared = FontManager()

    // MARK: Properties

    /// An array of bundle identifiers whose fonts have been registered by this class.
    private var registeredBundleIdentifiers: [String] = []

    /// An array of all available font family names.
    public var availableFontFamilies: [String] {
        Font.familyNames
    }

    /// An array of all available font family names along with their variations.
    public var availableFontFamiliesAndVariations: [String] {
        Font.familyNamesAndVariations
    }

    /// An array of all available fonts.
    public var availableFonts: [Font] {
        Font.allFonts
    }

    /// An array of all available fonts along with their variations.
    public var availableFontsAndVariations: [Font] {
        Font.allFontsAndVariations
    }

    // MARK: Initializers

    private init() {}

    // MARK: Methods

    /// Prints all available font family names to the console.
    public func printNames() {
        Font.printNames()
    }

    /// Prints all available font family names along with their variations to the console.
    public func printNamesAndVariations() {
        Font.printNamesAndVariations()
    }

    // MARK: Methods - Registration

    public func registerFonts(in bundle: Bundle, fileExtensions: [String] = ["ttf", "otf"]) throws {
        guard try !self.hasRegistered(bundle.bundleIdentifier) else {
            return
        }

        var bundleHasFonts = false

        for item in fileExtensions {
            do {
                try self.registerFonts(in: bundle, fileExtension: item)

                // If no error was thrown, then fonts for our bundle were successfully registered
                bundleHasFonts = true
            } catch RegistrationError.fontsNotFound {
                // Do nothing, we want to throw one error for the entire bundle
                // if no fonts are found, not an error per file extension
            } catch {
                throw error
            }
        }

        // If no fonts were found in the bundle with any file extension, throw an error that no founds were found.
        if !bundleHasFonts {
            throw RegistrationError.fontsNotFound(bundleID: bundle.bundleIdentifier)
        }

        if let bundleIdentifier = bundle.bundleIdentifier {
            self.registeredBundleIdentifiers.append(bundleIdentifier)
        }
    }

    private func registerFonts(in bundle: Bundle, fileExtension: String) throws {
        guard let fontURLs = bundle.urls(forResourcesWithExtension: fileExtension, subdirectory: nil), !fontURLs.isEmpty else {
            throw RegistrationError.fontsNotFound(bundleID: bundle.bundleIdentifier)
        }

        try fontURLs.forEach(self.register)
    }

    private func register(url: URL) throws {
        let fontName = url.lastPathComponent

        guard let fontDataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(fontDataProvider)
        else {
            throw RegistrationError.unableToCreateFont(name: fontName, reason: "Font at URL '\(url.absoluteString)' not found.")
        }

        do {
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)

            if let unwrappedError = error {
                // https://stackoverflow.com/a/43368507
                // https://developer.apple.com/documentation/swift/unmanaged/takeretainedvalue()
                throw unwrappedError.takeRetainedValue() as Error
            }

            // print("Registered font: \(fontName)")
        } catch {
            throw RegistrationError.unableToCreateFont(name: fontName, reason: error.localizedDescription)
        }
    }

    func hasRegistered(_ bundleIdentifier: String?) throws -> Bool {
        guard let bundleIdentifier else {
            throw RegistrationError.bundleIdentifierNotFound
        }

        return self.registeredBundleIdentifiers.contains(bundleIdentifier)
    }
}

// MARK: - Supporting Types

public extension FontManager {
    enum RegistrationError: LocalizedError {
        case fontsNotFound(bundleID: String?)
        case bundleIdentifierNotFound
        case unableToCreateFont(name: String, reason: String? = nil)

        public var errorDescription: String? {
            switch self {
            case let .fontsNotFound(bundleID):
                return "Fonts not found in bundle in '\(bundleID ?? "unknown")'."
            case .bundleIdentifierNotFound:
                return "Bundle identifier not found."
            case let .unableToCreateFont(name, reason):
                let message = "Unable to create the font '\(name)' from the provided data."

                if let reason {
                    return "\(message) \(reason)"
                } else {
                    return message
                }
            }
        }
    }
}

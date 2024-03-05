// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Extension to provide convenience methods for working with a `Color`'s hexadecimal values.
public extension Color {
    // MARK: Properties

    /// Retrieves the hexadecimal representation of the color.
    ///
    /// This method converts the color components to their hexadecimal representation
    /// and returns the resulting string. If the color components cannot be retrieved
    /// or if the color space does not have at least three components, nil is returned.
    ///
    /// - Returns: A hexadecimal representation of the color, or nil if it cannot be obtained.
    var hex: String? {
        // Retrieve the color components from the CGColor object
        guard let components = UXColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0]) // Red component
        let g = Float(components[1]) // Green component
        let b = Float(components[2]) // Blue component
        var a = Float(1.0) // Alpha component, default value is 1.0 (fully opaque)

        // Check if the color has an alpha component
        if components.count >= 4 {
            a = Float(components[3])
        }

        // Convert color components to their hexadecimal representation
        if a != Float(1.0) {
            // If the color has an alpha component, format the hexadecimal string accordingly
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            // If the color does not have an alpha component, format the hexadecimal string accordingly
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

    // MARK: Methods

    /// Initializes a `Color` with a given hexadecimal value and optional alpha value.
    /// - Parameters:
    ///   - hex: The hexadecimal value representing the color.
    ///   - alpha: The opacity of the color. Defaults to `1.0`.
    init(hex: UInt, alpha: Double = 1.0) {
        // Extract the red, green, and blue components from the hexadecimal value.
        // Explanation:
        // - The "&" operator performs a bitwise AND operation.
        // - ">>" shifts the bits of the hexadecimal value to the right.
        // - The bitwise AND operations extract the red, green, and blue components from the hexadecimal value.
        // - Each color component is then divided by 255.0 to normalize the value between 0 and 1.
        //   This is necessary because colors are typically represented using floating-point values between 0 and 1.
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Initializes a `Color` with a given hexadecimal string and optional alpha value.
    /// - Parameters:
    ///   - hexString: The hexadecimal string representing the color.
    ///   - alpha: The opacity of the color. Defaults to `1.0`.
    init(hex hexString: String, alpha: Double = 1.0) {
        // Ensure we only have alphanumeric characters
        var formattedHexString = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        // Ensure the hexadecimal string is properly formatted
        if formattedHexString.count == 3 {
            formattedHexString = String(formattedHexString.flatMap { [$0, $0] })
        }

        // Convert the hexadecimal string to a UInt value
        if let hexValue = UInt(formattedHexString, radix: 16) {
            self.init(hex: hexValue, alpha: alpha)
        } else {
            // Default to black if unable to parse the hexadecimal string
            self = .black
        }
    }
}

// MARK: - UIKit / AppKit Extensions

public extension UXColor {
    // MARK: Properties

    /// Retrieves the hexadecimal representation of the color.
    ///
    /// This property converts the color components to their hexadecimal representation
    /// and returns the resulting string. If the color components cannot be retrieved
    /// or if the color space does not have at least three components, nil is returned.
    ///
    /// - Returns: A hexadecimal representation of the color, or nil if it cannot be obtained.
    var hex: String? {
        // Retrieve the color components from the CGColor object
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

    // MARK: Methods

    /// Initializes a UIColor instance with a given hexadecimal value and optional alpha value.
    ///
    /// - Parameters:
    ///   - hex: The hexadecimal value representing the color.
    ///   - alpha: The opacity of the color. Defaults to `1.0`.
    convenience init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Initializes a UIColor instance with a given hexadecimal string and optional alpha value.
    ///
    /// - Parameters:
    ///   - hexString: The hexadecimal string representing the color.
    ///   - alpha: The opacity of the color. Defaults to `1.0`.
    convenience init(hex hexString: String, alpha: Double = 1.0) {
        var formattedHexString = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        // Ensure the hexadecimal string is properly formatted
        if formattedHexString.count == 3 {
            formattedHexString = String(formattedHexString.flatMap { [$0, $0] })
        }

        // Convert the hexadecimal string to a UInt value
        if let hexValue = UInt(formattedHexString, radix: 16) {
            self.init(hex: hexValue, alpha: alpha)
        } else {
            // Default to black if unable to parse the hexadecimal string
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 0) {
        Color(hex: 0x000000)
        Color(hex: 0xFF0000)
        Color(hex: 0x00FF00)
        Color(hex: 0x0000FF)
        Color(hex: 0xFFFFFF)
    }
    .background(.purple)
}

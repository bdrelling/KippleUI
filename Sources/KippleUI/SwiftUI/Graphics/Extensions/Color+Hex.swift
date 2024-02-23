// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    init(hex hexString: String, alpha: Double = 1.0) {
        var formattedHexString = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        if formattedHexString.count == 3 {
            formattedHexString = String(formattedHexString.flatMap { [$0, $0] })
        }

        if let hexValue = UInt(formattedHexString, radix: 16) {
            self.init(hex: hexValue, alpha: alpha)
        } else {
            self = .black
        }
    }
}

// source: https://blog.eidinger.info/from-hex-to-color-and-back-in-swiftui
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension Color {
    var hex: String? {
        guard let components = UXColor(self).cgColor.components, components.count >= 3 else {
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
}

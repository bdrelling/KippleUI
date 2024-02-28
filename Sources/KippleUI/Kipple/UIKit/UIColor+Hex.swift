// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension UIColor {
    convenience init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(hex hexString: String, alpha: Double = 1.0) {
        var formattedHexString = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        if formattedHexString.count == 3 {
            formattedHexString = String(formattedHexString.flatMap { [$0, $0] })
        }

        if let hexValue = UInt(formattedHexString, radix: 16) {
            self.init(hex: hexValue, alpha: alpha)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}

#endif

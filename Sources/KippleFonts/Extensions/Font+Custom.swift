// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font {
    static func custom(_ name: String, relativeTo textStyle: Font.TextStyle, multiplier: CGFloat = 1) -> Font {
        self.custom(name, size: textStyle.preferredSize * multiplier, relativeTo: textStyle)
    }

    static func custom(_ name: RegisteredFontName, size: CGFloat? = nil, relativeTo style: TextStyle = .body) -> Self {
        if let size {
            return .custom(name.value, size: size, relativeTo: style)
        } else {
            return .custom(name.value, relativeTo: style)
        }
    }
}

// MARK: - Supporting Types

public struct RegisteredFontName {
    fileprivate let value: String
}

// MARK: - Extensions

extension RegisteredFontName: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value: value)
    }
}

// MARK: - UIKit / AppKit Extensions

public extension UXFont {
    static func custom(_ name: String, relativeTo textStyle: UXFont.TextStyle) -> UXFont {
        .init(name: name, relativeTo: textStyle) ?? .systemFont(ofSize: textStyle.preferredSize)
    }

    static func custom(_ name: RegisteredFontName, relativeTo textStyle: UXFont.TextStyle) -> UXFont {
        self.custom("\(name.value)", relativeTo: textStyle)
    }
}

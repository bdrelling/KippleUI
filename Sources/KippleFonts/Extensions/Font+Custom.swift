// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font {
    static func custom(_ name: String, relativeTo textStyle: Font.TextStyle) -> Self {
        .custom(name, size: textStyle.preferredSize, relativeTo: textStyle)
    }

    static func custom(_ name: RegisteredFontName, size: CGFloat? = nil, relativeTo style: Font.TextStyle = .body) -> Self {
        if let size {
            return .custom(name.value, size: size, relativeTo: style)
        } else {
            return .custom(name.value, relativeTo: style)
        }
    }

    static func custom(_ name: RegisteredFontName, fixedSize: CGFloat) -> Self {
        .custom(name.value, fixedSize: fixedSize)
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

// MARK: - Favorites

/// A collection of favorite fonts that exist on Apple platforms.
public extension RegisteredFontName {
    static let copperplate: Self = "Copperplate"
    static let courierNew: Self = "Courier New"
    static let futura: Self = "Futura"
    static let kefa: Self = "Kefa"
    static let menlo: Self = "Menlo"
    static let palatino: Self = "Palatino"
    static let rockwell: Self = "Rockwell"
    static let trebuchetMS: Self = "Trebuchet MS"
    static let verdana: Self = "Verdana"
}

public extension Font {
    static func copperplate(_ style: TextStyle = .body) -> Self {
        self.custom(.copperplate, relativeTo: style)
    }

    static func copperplate(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.copperplate, size: size, relativeTo: style)
    }

    static func courierNew(_ style: TextStyle = .body) -> Self {
        self.custom(.courierNew, relativeTo: style)
    }

    static func courierNew(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.courierNew, size: size, relativeTo: style)
    }

    static func futura(_ style: TextStyle = .body) -> Self {
        self.custom(.futura, relativeTo: style)
    }

    static func futura(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.futura, size: size, relativeTo: style)
    }

    static func kefa(_ style: TextStyle = .body) -> Self {
        self.custom(.kefa, relativeTo: style)
    }

    static func kefa(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.kefa, size: size, relativeTo: style)
    }

    static func menlo(_ style: TextStyle = .body) -> Self {
        self.custom(.menlo, relativeTo: style)
    }

    static func menlo(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.menlo, size: size, relativeTo: style)
    }

    static func palatino(_ style: TextStyle = .body) -> Self {
        self.custom(.palatino, relativeTo: style)
    }

    static func palatino(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.palatino, size: size, relativeTo: style)
    }

    static func rockwell(_ style: TextStyle = .body) -> Self {
        self.custom(.rockwell, relativeTo: style)
    }

    static func rockwell(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.rockwell, size: size, relativeTo: style)
    }

    static func trebuchetMS(_ style: TextStyle = .body) -> Self {
        self.custom(.trebuchetMS, relativeTo: style)
    }

    static func trebuchetMS(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.trebuchetMS, size: size, relativeTo: style)
    }

    static func verdana(_ style: TextStyle = .body) -> Self {
        self.custom(.verdana, relativeTo: style)
    }

    static func verdana(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.verdana, size: size, relativeTo: style)
    }
}

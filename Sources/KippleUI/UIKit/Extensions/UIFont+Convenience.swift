// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension UIFont {
    convenience init?(name: String, relativeTo textStyle: TextStyle) {
        self.init(name: name, size: textStyle.preferredSize)
    }

    static var allFonts: [UIFont] {
        UIFont.familyNames
            .sorted()
            .compactMap { UIFont(name: $0, relativeTo: .body) }
    }

    static var allFontsAndVariations: [UIFont] {
        UIFont.familyNames
            .sorted()
            .flatMap(UIFont.fontNames)
            .compactMap { UIFont(name: $0, relativeTo: .body) }
    }
}

#endif

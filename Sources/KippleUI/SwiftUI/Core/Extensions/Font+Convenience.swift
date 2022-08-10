// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

public extension Font {
    static func preferredFont(forTextStyle textStyle: Font.TextStyle) -> UIFont {
        UIFont.preferredFont(forTextStyle: textStyle.uiTextStyle)
    }

    static func custom(_ name: String, relativeTo textStyle: Font.TextStyle) -> Font {
        self.custom(name, size: textStyle.preferredSize, relativeTo: textStyle)
    }
}

#endif

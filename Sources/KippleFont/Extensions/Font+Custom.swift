// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font {
    static func custom(_ name: String, relativeTo textStyle: Font.TextStyle, multiplier: CGFloat = 1) -> Font {
        self.custom(name, size: textStyle.preferredSize * multiplier, relativeTo: textStyle)
    }
}

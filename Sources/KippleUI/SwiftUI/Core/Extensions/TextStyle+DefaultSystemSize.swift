// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

    import SwiftUI

    public extension Font.TextStyle {
        var defaultSystemSize: CGFloat {
            Font.preferredFont(forTextStyle: self).pointSize
        }
    }

#endif

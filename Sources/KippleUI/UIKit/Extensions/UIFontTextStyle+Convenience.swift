// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension UIFont.TextStyle {
    var preferredSize: CGFloat {
        UIFont.preferredFont(forTextStyle: self).pointSize
    }
}

#endif

// Copyright © 2023 Brian Drelling. All rights reserved.

import CoreGraphics

public extension CGSize {
    var center: CGPoint {
        .init(x: self.width / 2, y: self.height / 2)
    }

    var isLandscape: Bool {
        self.width > self.height
    }

    var isPortrait: Bool {
        self.height > self.width
    }

    var isSquare: Bool {
        self.width == self.height
    }

    static func * (lhs: Self, rhs: CGFloat) -> Self {
        .init(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}

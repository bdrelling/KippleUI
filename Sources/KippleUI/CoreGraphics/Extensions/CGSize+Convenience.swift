// Copyright © 2024 Brian Drelling. All rights reserved.

import CoreGraphics

// TODO: Write tests
public extension CGSize {
    var center: CGPoint {
        .init(x: width / 2, y: height / 2)
    }

    var isLandscape: Bool {
        width > height
    }

    var isPortrait: Bool {
        height > width
    }

    var isSquare: Bool {
        width == height
    }

    static func * (lhs: Self, rhs: CGFloat) -> Self {
        .init(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import CoreGraphics

public extension CGRect {
    var center: CGPoint {
        .init(x: midX, y: midY)
    }
}

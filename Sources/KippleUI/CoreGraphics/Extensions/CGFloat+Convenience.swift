// Copyright © 2024 Brian Drelling. All rights reserved.

import CoreGraphics

// TODO: Write tests
public extension CGFloat {
    func rounded(places: Int) -> CGFloat {
        let multiplier = pow(CGFloat(10), CGFloat(places))
        return floor(self * multiplier) / multiplier
    }
}

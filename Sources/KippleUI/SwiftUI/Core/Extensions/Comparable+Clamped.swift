// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

// TODO: Move to KippleCore
public extension Comparable {
    /// Ensures this value is clamped between the lower and upper bound of a given closed range.
    func clamped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound {
            return range.lowerBound
        } else if self > range.upperBound {
            return range.upperBound
        } else {
            return self
        }
    }

    /// Ensures this value is clamped between the lower and upper bound of a given closed range.
    func clamped(min: Self, max: Self) -> Self {
        if self < min {
            return min
        } else if self > max {
            return max
        } else {
            return self
        }
    }
}

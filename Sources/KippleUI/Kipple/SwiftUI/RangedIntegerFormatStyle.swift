// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// A parseable format style for bounding an `Int`-based `TextField`.
public struct RangedIntegerFormatStyle: ParseableFormatStyle {
    public struct Strategy: ParseStrategy {
        public func parse(_ value: String) throws -> Int {
            Int(value) ?? 0
        }
    }

    public var parseStrategy: Strategy = .init()
    public let range: ClosedRange<Int>

    public func format(_ value: Int) -> String {
        if self.range.contains(value) {
            return "\(value)"
        } else {
            return ""
        }
    }
}

// MARK: - Convenience

public extension FormatStyle where Self == RangedIntegerFormatStyle {
    static func ranged(_ range: ClosedRange<Int>) -> Self {
        .init(range: range)
    }
}

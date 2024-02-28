// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// A parseable format style for bounding an `Double`-based `TextField`.
public struct RangedDoubleFormatStyle: ParseableFormatStyle {
    public struct Strategy: ParseStrategy {
        public func parse(_ value: String) throws -> Double {
            Double(value) ?? 0
        }
    }

    public var parseStrategy: Strategy = .init()
    public let range: ClosedRange<Double>

    public func format(_ value: Double) -> String {
        if self.range.contains(value) {
            return "\(value)"
        } else {
            return ""
        }
    }
}

// MARK: - Convenience

public extension FormatStyle where Self == RangedDoubleFormatStyle {
    static func ranged(_ range: ClosedRange<Double>) -> Self {
        .init(range: range)
    }
}

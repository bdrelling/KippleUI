// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct IsHighlightedEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isHighlighted: Bool {
        get { self[IsHighlightedEnvironmentKey.self] }
        set { self[IsHighlightedEnvironmentKey.self] = newValue }
    }
}

// MARK: - Extensions

public extension View {
    func highlighted(_ isHighlighted: Bool) -> some View {
        self.environment(\.isHighlighted, isHighlighted)
    }
}

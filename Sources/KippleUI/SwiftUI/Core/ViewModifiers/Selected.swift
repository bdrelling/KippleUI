// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct Selected {
    let itemVerticalSpacing: CGFloat
    let itemHorizontalSpacing: CGFloat
}

// MARK: - Supporting Types

private struct IsSelectedEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isSelected: Bool {
        get { self[IsSelectedEnvironmentKey.self] }
        set { self[IsSelectedEnvironmentKey.self] = newValue }
    }
}

// MARK: - Extensions

public extension View {
    func selected(_ isSelected: Bool) -> some View {
        self.environment(\.isSelected, isSelected)
    }
}

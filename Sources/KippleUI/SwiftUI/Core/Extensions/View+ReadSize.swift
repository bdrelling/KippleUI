// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    func readSize(_ onSizeChange: @escaping (CGSize) -> Void) -> some View {
        self.overlay(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onSizeChange)
    }
}

// MARK: - Supporting Types

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

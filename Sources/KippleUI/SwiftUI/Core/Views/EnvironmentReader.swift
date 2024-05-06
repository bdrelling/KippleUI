// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct EnvironmentReader<Content, Value>: View where Content: View {
    @Environment private var value: Value

    private let keyPath: KeyPath<EnvironmentValues, Value>
    private let content: (Value) -> Content

    public var body: some View {
        self.content(self.value)
    }

    public init(_ keyPath: KeyPath<EnvironmentValues, Value>, @ViewBuilder content: @escaping (Value) -> Content) {
        self._value = Environment(keyPath)
        self.keyPath = keyPath
        self.content = content
    }
}

// MARK: - Previews

#Preview {
    EnvironmentReader(\.colorScheme) { colorScheme in
        Text("Wow!")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
    }
    .environment(\.colorScheme, .dark)
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct CheckerboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .colorEffect(
                ShaderLibrary.checkerboard(
                    .float(10),
                    .color(.blue)
                )
            )
    }
}

// MARK: - Extensions

public extension View {
    func checkerboard() -> some View {
        self.modifier(CheckerboardModifier())
    }
}

// MARK: - Previews

#Preview {
    Image(systemName: "photo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .checkerboard()
        .padding(64)
}

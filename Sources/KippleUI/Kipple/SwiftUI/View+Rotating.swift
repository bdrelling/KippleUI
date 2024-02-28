// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Perpetually rotates a `View` forever.
private struct RotatingModifier: ViewModifier {
    private let animation: Animation

    @State private var rotationDegrees: Double = 0

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(self.rotationDegrees))
            .animation(self.animation.repeatForever(autoreverses: false), value: self.rotationDegrees)
            .onAppear {
                self.rotationDegrees = 360
            }
    }

    init(animation: Animation) {
        self.animation = animation
    }

    init(duration: TimeInterval = 1) {
        self.init(animation: .linear(duration: duration))
    }
}

// MARK: - Extensions

public extension View {
    /// Perpetually rotate a `View` forever, with each rotation taking the provided duration.
    func rotating(duration: TimeInterval) -> some View {
        modifier(RotatingModifier(duration: duration))
    }
}

// MARK: - Previews

struct RotatingModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Woooo!")
            .rotating(duration: 1)
    }
}

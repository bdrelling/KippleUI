// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

private struct RHPulsingModifier: ViewModifier {
    private static let growScale: CGFloat = 1.3
    private static let defaultScale: CGFloat = 1
    private static let duration: TimeInterval = 1

    @State private var scaleValue = Self.defaultScale

    private var animation: Animation {
        .easeInOut(duration: Self.duration).repeatForever(autoreverses: true)
    }

    func body(content: Content) -> some View {
        content
            .scaleEffect(self.scaleValue)
            .animation(self.animation, value: self.scaleValue)
            .onAppear {
                self.scaleValue = Self.growScale
            }
    }
}

// MARK: - Extensions

public extension View {
    func pulsing() -> some View {
        modifier(RHPulsingModifier())
    }
}

// MARK: - Previews

struct ViewPulse_Previews: PreviewProvider {
    static var previews: some View {
        Text("Pulse")
            .pulsing()
    }
}

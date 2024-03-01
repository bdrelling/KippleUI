// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    /// Prevents the screen from dimming when this applied to a `View` that has appeared.
    /// When the `View` disappears, the screen is able to dim again.
    @ViewBuilder
    func preventScreenDimming() -> some View {
        #if canImport(UIKit)
        self.onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        #else
        self
        #endif
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

private struct DisableDynamicTypeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(.large) // Force the default size no matter the user's settings
    }
}

// MARK: - Extensions

public extension View {
    /// Forces the default size no matter the user's settings.
    func disableDynamicType() -> some View {
        modifier(DisableDynamicTypeModifier())
    }
}

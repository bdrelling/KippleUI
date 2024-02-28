// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct NoButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        /// Just return the label.
        /// This ensures there's absolutely no styling (unlike .plain, which highlights the label on tap).
        configuration.label
    }
}

// MARK: - Convenience

public extension ButtonStyle where Self == NoButtonStyle {
    /// Use on a button where no styling OR highlighting is desired.
    static var none: Self {
        NoButtonStyle()
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    /// Disables ligatures from appearing.
    func disableLigatures() -> some View {
        // Source: https://stackoverflow.com/a/77502626/706771
        self.tracking(0.1)
    }
}

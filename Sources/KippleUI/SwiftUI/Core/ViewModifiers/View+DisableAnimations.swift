// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    @ViewBuilder
    func disableAnimations() -> some View {
        self.transaction { transaction in
            transaction.animation = nil
        }
    }
}

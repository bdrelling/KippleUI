// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    @ViewBuilder
    func refreshable(isRefreshable: Bool, action: @escaping () async -> Void) -> some View {
        if isRefreshable {
            self.refreshable {
                await action()
            }
        } else {
            self
        }
    }
}

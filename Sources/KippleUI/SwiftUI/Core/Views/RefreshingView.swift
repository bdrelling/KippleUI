// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct RefreshingView<Content>: View where Content: View {
    @Environment(\.refresh) private var refresh

    @ViewBuilder var content: (RefreshAction?) -> Content

    public var body: some View {
        self.content(self.refresh)
    }

    init(@ViewBuilder _ content: @escaping (RefreshAction?) -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    /// Enables the `KipplePicker` to refresh when loaded if options are unavailable.
    func refreshOnAppear(if condition: Bool) -> some View {
        RefreshingView { refresh in
            self.task {
                if condition {
                    await refresh?()
                }
            }
        }
    }
}

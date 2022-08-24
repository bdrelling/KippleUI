// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

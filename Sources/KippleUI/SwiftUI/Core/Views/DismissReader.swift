// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public struct DismissReader<Content>: View where Content: View {
    @Environment(\.dismiss) private var dismiss

    @ViewBuilder var content: (DismissAction) -> Content

    public var body: some View {
        self.content(self.dismiss)
    }

    public init(@ViewBuilder _ content: @escaping (DismissAction) -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

@available(watchOS, unavailable)
public extension View {
    /// Adds a dismiss button to the toolbar.
    func withNavigationBarDoneButton(if condition: Bool = true) -> some View {
        DismissReader { dismiss in
            self.toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Text("Done")
                    }
                }
                #elseif os(macOS)
                ToolbarItem(placement: .navigation) {
                    Button(action: { dismiss() }) {
                        Text("Done")
                    }
                }
                #endif
            }
        }
    }
}

// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct DismissingView<Content>: View where Content: View {
    @Environment(\.dismiss) private var dismiss

    @ViewBuilder var content: (DismissAction) -> Content

    public var body: some View {
        self.content(self.dismiss)
    }

    init(@ViewBuilder _ content: @escaping (DismissAction) -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    /// Adds a dismiss button to the toolbar.
    func withNavigationBarDoneButton(if condition: Bool = true) -> some View {
        DismissingView { dismiss in
            self.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Text("Done")
                    }
                }
            }
        }
    }
}

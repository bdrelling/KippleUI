// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
public extension View {
    /// Adds a dismiss button to the toolbar.
    func withNavigationBarDoneButton(if condition: Bool = true) -> some View {
        DismissReader { dismiss in
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

#endif

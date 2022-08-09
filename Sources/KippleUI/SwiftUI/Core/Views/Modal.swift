// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct Modal<Content>: View where Content: View {
    @Environment(\.dismiss) private var dismiss

    private let content: () -> Content

    public var body: some View {
        NavigationView {
            self.content()
                .withFauxNaivgationBarBackground()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { self.dismiss() }) {
                            Text("Done")
                        }
                    }
                }
        }
    }

    public init(_ content: Content) {
        self.content = { content }
    }

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    func inModal() -> some View {
        Modal {
            self
        }
    }
}

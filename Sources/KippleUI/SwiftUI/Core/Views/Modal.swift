// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

public struct Modal<Content>: View where Content: View {
    private let content: () -> Content

    public var body: some View {
        #if os(tvOS)
        NavigationView {
            self.content()
                .withNavigationBarDoneButton()
        }
        #else
        NavigationView {
            self.content()
                .withNavigationBarBackground {
                    Rectangle()
                        .fill(.regularMaterial)
                }
                .navigationBarTitleDisplayMode(.inline)
                .withNavigationBarDoneButton()
        }
        #endif
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

#endif

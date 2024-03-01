// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

@available(watchOS, unavailable)
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
                    #if os(watchOS)
                        .fill(.background)
                    #else
                        .fill(.regularMaterial)
                    #endif
                }
//                .navigationBarTitleDisplayMode(.inline)
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

@available(watchOS, unavailable)
public extension View {
    func inModal() -> some View {
        Modal {
            self
        }
    }
}

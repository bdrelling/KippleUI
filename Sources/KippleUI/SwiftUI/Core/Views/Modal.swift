// Copyright © 2023 Brian Drelling. All rights reserved.

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public extension View {
    func inModal() -> some View {
        Modal {
            self
        }
    }
}

#endif

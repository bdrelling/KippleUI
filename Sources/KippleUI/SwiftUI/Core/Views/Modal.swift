// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct Modal<Content>: View where Content: View {
    private let content: () -> Content

    public var body: some View {
        NavigationView {
            self.content()
                .withFauxNaivgationBarBackground()
                .navigationBarTitleDisplayMode(.inline)
                .withNavigationBarDoneButton()
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
    func inModal() -> some View {
        Modal {
            self
        }
    }
}

#endif

// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

@available(watchOS 7.0, *)
public extension View {
    func inNavigationView() -> some View {
        modifier(EmbedInNavigationViewModifier())
    }

    @ViewBuilder
    func inNavigationView(_ inNavigation: Bool) -> some View {
        if inNavigation {
            self.inNavigationView()
        } else {
            self
        }
    }
}

@available(watchOS 7.0, *)
struct EmbedInNavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        NavigationView {
            content
        }
        .navigationViewStyle(.stack)
    }
}

#endif

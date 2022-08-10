// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

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

struct EmbedInNavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        NavigationView {
            content
        }
        .navigationViewStyle(.stack)
    }
}

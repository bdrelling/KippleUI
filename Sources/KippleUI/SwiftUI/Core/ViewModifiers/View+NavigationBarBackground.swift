// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS)

import SwiftUI

public struct NavigationBarBackground<Content>: View where Content: View {
    private let content: () -> Content

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                self.content()
                    .frame(height: geometry.safeAreaInsets.top)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    func withNavigationBarBackground<Content>(@ViewBuilder _ content: @escaping () -> Content) -> some View where Content: View {
        self.overlay(NavigationBarBackground(content))
    }
}

// MARK: - Previews

struct NavigationBarBackground_Previews: PreviewProvider {
    private static let displayModes: [NavigationBarItem.TitleDisplayMode] = [
        .inline,
        .large,
    ]

    static var previews: some View {
        ForEach(self.displayModes, id: \.self) { displayMode in
            NavigationView {
                ZStack {
                    NavigationBarBackground {
                        Color.blue
                    }

                    Text("View")
                }
                .navigationBarTitle("Title", displayMode: displayMode)
            }
        }
        .previewMatrix(.currentDevice)
    }
}

#endif

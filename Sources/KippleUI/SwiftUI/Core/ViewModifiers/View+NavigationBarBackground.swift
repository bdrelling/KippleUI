// Copyright © 2024 Brian Drelling. All rights reserved.

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
        overlay(NavigationBarBackground(content))
    }
}

// MARK: - Previews

#if canImport(UIKit)

struct NavigationBarBackground_Previews: PreviewProvider {
    #if os(iOS)
    private static let displayModes: [NavigationBarItem.TitleDisplayMode] = [
        .inline,
        .large,
    ]
    #else
    private static let displayModes: [NavigationBarItem.TitleDisplayMode] = [
        .inline,
    ]
    #endif

    static var previews: some View {
        ForEach(displayModes, id: \.self) { displayMode in
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

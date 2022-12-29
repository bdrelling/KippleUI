// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS)

import SwiftUI

public struct FauxNavigationBarBackground<Content>: View where Content: View {
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
    func withFauxNavigationBarBackground<Content>(@ViewBuilder _ content: @escaping () -> Content) -> some View where Content: View {
        self.overlay(FauxNavigationBarBackground(content))
    }
}

public extension View {
    func withFauxNavigationBarBackground() -> some View {
        self.overlay(FauxNavigationBarBackground())
    }
}

public extension FauxNavigationBarBackground where Content == VisualEffectView {
    init() {
        self.init {
            VisualEffectView(effect: UIBlurEffect(style: .regular))
        }
    }
}

// MARK: - Previews

struct FauxNavigationBarBackground_Previews: PreviewProvider {
    private static let displayModes: [NavigationBarItem.TitleDisplayMode] = [
        .inline,
        .large,
    ]

    static var previews: some View {
        ForEach(self.displayModes, id: \.self) { displayMode in
            NavigationView {
                ZStack {
                    FauxNavigationBarBackground {
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

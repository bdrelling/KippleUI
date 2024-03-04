// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct PreviewBackground: ViewModifier {
    public static let colors: [Color] = [.red, .green, .orange, .blue, .yellow, .purple]

    @Environment(\.previewBackgroundColor) public var backgroundColor

    public func body(content: Content) -> some View {
        content
            .environment(\.previewBackgroundColor, self.nextColor())
            .background(self.backgroundColor)
    }

    private func nextColor() -> Color {
        guard let index = Self.colors.firstIndex(of: backgroundColor) else {
            return Self.colors.first ?? self.backgroundColor
        }

        var nextIndex = index + 1

        if nextIndex >= Self.colors.count {
            nextIndex = 0
        }

        return Self.colors[nextIndex]
    }
}

// MARK: - Extensions

private struct PreviewBackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color = PreviewBackground.colors.first ?? .clear
}

public extension EnvironmentValues {
    var previewBackgroundColor: Color {
        get { self[PreviewBackgroundColorKey.self] }
        set { self[PreviewBackgroundColorKey.self] = newValue }
    }
}

public extension View {
    func previewBackground() -> some View {
        modifier(PreviewBackground())
    }
}

// MARK: - Previews

struct PreviewBackground_Previews: PreviewProvider {
    private static let spacing: CGFloat = 20

    static var previews: some View {
        GeometryReader { _ in
            ZStack {
                HStack(spacing: spacing) {
                    VStack(spacing: spacing) {
                        Text("Text")
                            .previewBackground()
                        Text("Text")
                            .previewBackground()
                        Text("Text")
                            .previewBackground()
                    }
                    .padding()
                    .previewBackground()

                    VStack(spacing: spacing) {
                        Text("Text")
                            .previewBackground()
                        Text("Text")
                            .previewBackground()
                        Text("Text")
                            .previewBackground()
                    }
                    .padding()
                    .previewBackground()
                }
                .padding()
                .previewBackground()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .previewBackground()
        .edgesIgnoringSafeArea(.all)
    }
}

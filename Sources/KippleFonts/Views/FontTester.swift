// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct FontTester<Content>: View where Content: View {
    private let columns: Int
    private let colors: [ColorPair]
    private let fonts: [UXFont]
    private let textStyle: Font.TextStyle
    private let content: () -> Content

    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible(), spacing: 8), count: self.columns),
                spacing: 8
            ) {
                FontIterator(self.fonts) { font, familyName in
                    ForEach(Array(self.colors.enumerated()), id: \.offset) { index, colors in

                        VStack(alignment: .leading) {
                            Text(familyName)
                                .font(.caption)
                                .foregroundColor(.secondary)

                            self.content()
                                .font(.custom(familyName, relativeTo: self.textStyle))
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .foregroundStyle(colors.foreground)
                                .background(colors.background)
                        }
                        .id("\(font.hashValue)-\(index)")
                    }
                }
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(
        columns: Int? = nil,
        fonts: [UXFont] = UXFont.allFonts,
        colors: [ColorPair] = .default,
        textStyle: Font.TextStyle = .title,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.columns = columns ?? colors.count
        self.fonts = fonts
        self.colors = colors
        self.textStyle = textStyle
        self.content = content
    }

    public init(
        columns: Int? = nil,
        fonts: [UXFont] = UXFont.allFonts,
        color: ColorPair,
        textStyle: Font.TextStyle = .title,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            columns: columns,
            fonts: fonts,
            colors: [color],
            textStyle: textStyle,
            content: content
        )
    }
}

public struct ColorPair: Equatable, Hashable {
    public let foreground: Color
    public let background: Color

    public init(foreground: Color, background: Color) {
        self.foreground = foreground
        self.background = background
    }
}

public extension ColorPair {
    static let blackOnWhite: Self = .init(foreground: .black, background: .white)
    static let whiteOnBlack: Self = .init(foreground: .white, background: .black)
}

public extension Array where Element == ColorPair {
    static let `default`: [ColorPair] = [
        .whiteOnBlack,
        .blackOnWhite,
    ]
}

// MARK: - Previews

struct FontTester_Previews: PreviewProvider {
    static var previews: some View {
        FontTester(
            columns: 2,
            colors: .default + [
                .init(foreground: .white, background: .blue),
                .init(foreground: .blue, background: .white),
            ]
        ) {
            Text("Lorem ipsum")
        }
    }
}

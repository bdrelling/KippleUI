// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct ColorPalette: View {
    private let spacing: CGFloat
    private let colors: [ColorSet]

    public var body: some View {
        Grid(horizontalSpacing: self.spacing, verticalSpacing: self.spacing) {
            ForEach(self.colors, id: \.self) { colorSet in
                GridRow {
                    ForEach(colorSet.backgrounds, id: \.self) { background in
                        Group {
                            if let background {
                                ColorSquare(background)
                                    .foregroundColor(colorSet.foreground)
                            } else {
                                Color.clear
                                    .gridCellUnsizedAxes([.horizontal, .vertical])
                            }
                        }
                    }
                }
            }
        }
    }

    public init(spacing: CGFloat = 0, colors: [ColorSet]) {
        self.spacing = spacing
        self.colors = colors
    }

    public init(spacing: CGFloat = 0, colors: [(Color, on: [Color?])]) {
        self.spacing = spacing
        self.colors = colors.map(ColorSet.init)
    }
}

// MARK: - Supporting Types

public struct ColorSet: Hashable {
    public let foreground: Color
    public let backgrounds: [Color?]

    public init(foreground: Color, backgrounds: [Color?]) {
        self.foreground = foreground
        self.backgrounds = backgrounds
    }
}

public struct ColorSquare: View {
    private let color: Color

    public var body: some View {
        self.color
            .overlay {
                if let hex = color.hex {
                    Text("#\(hex)")
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .padding(4)
                }
            }
            .aspectRatio(1, contentMode: .fit)
    }

    public init(_ color: Color) {
        self.color = color
    }
}

// MARK: - Previews

struct ColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        ColorPalette(spacing: 4, colors: [
            (.black, on: [
                .white,
                nil,
                .red,
                .green,
                .blue,
                .yellow,
            ]),
            (.white, on: [
                nil,
                .black,
                .red,
                .green,
                .blue,
                .yellow,
            ]),
            (.red, on: [
                .white,
                .black,
            ]),
            (.green, on: [
                .white,
                .black,
            ]),
            (.blue, on: [
                .white,
                .black,
            ]),
            (.yellow, on: [
                .white,
                .black,
            ]),
        ])
        .padding(40)
        .background(Color.gray)
        .previewLayout(.sizeThatFits)
        .previewColorSchemes([.dark, .light])
    }
}

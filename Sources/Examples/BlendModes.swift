// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct BlendModeView: View {
    let fillColor: Color
    let glowColor: Color

    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            self.fillColor,
                            self.fillColor.darker(byPercentage: 30),
                            self.fillColor,
                        ]),
                        center: .top,
                        startRadius: 0,
                        endRadius: geometry.size.width * 2
                    )
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .overlay {
                    self.glowColor.opacity(0.35)
                        .clipShape(Circle())
                }
                .rotationEffect(.degrees(-30))
                .glow(color: self.glowColor, radius: 20)
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
    }

    init(fill: Color, glow: Color) {
        self.fillColor = fill
        self.glowColor = glow
    }
}

struct BlendMode_Previews: PreviewProvider {
    static let columns = [
        GridItem(.adaptive(minimum: 120)),
    ]

    static var previews: some View {
        LazyVGrid(columns: Self.columns, spacing: 40) {
            ForEach(BlendMode.allCases, id: \.self) { blendMode in
                VStack {
                    Sphere(fill: .green)
                        .blendMode(blendMode)
                    Text(String(describing: blendMode))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 1200, maxHeight: .infinity)
        .background(Color(hex: "e7e7e7"))
    }
}

extension BlendMode: CaseIterable {
    public static var allCases: [BlendMode] {
        [
            .normal,
            .multiply,
            .screen,
            .overlay,
            .darken,
            .lighten,
            .colorDodge,
            .colorBurn,
            .softLight,
            .hardLight,
            .difference,
            .exclusion,
            .hue,
            .saturation,
            .color,
            .luminosity,
            .sourceAtop,
            .destinationOver,
            .destinationOut,
            .plusDarker,
            .plusLighter,
        ]
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

@_implementationOnly import KippleColors
import SwiftUI

public struct Sphere: View {
    private let fillColor: Color
    private let rotationAngle: Angle

    public var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            self.fillColor,
                            self.fillColor.darker(byPercentage: 35),
                            self.fillColor,
                        ]),
                        center: .top,
                        startRadius: 0,
                        endRadius: geometry.size.width * 2
                    )
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(self.rotationAngle)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    public init(fill: Color, rotation: Angle = .degrees(-30)) {
        self.fillColor = fill
        self.rotationAngle = rotation
    }
}

// MARK: - Previews

struct Sphere_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Color.primary.colorInvert()
                Sphere(fill: .blue)
                    .padding(80)
            }

            ZStack {
                Color.primary
                Sphere(fill: .blue)
                    .padding(80)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

// Source: https://swiftui-lab.com/swiftui-animations-part1/
public struct Polygon: Shape {
    public let sides: Double

    public init(sides: Double) {
        self.sides = sides
    }

    public func path(in rect: CGRect) -> Path {
        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)

        var path = Path()

        let extra: Int = self.sides != Double(Int(self.sides)) ? 1 : 0

        for i in 0 ..< Int(self.sides) + extra {
            let angle = (Double(i) * (360.0 / self.sides)) * (Double.pi / 180)

            // Calculate vertex
            let vertex = CGPoint(x: center.x + CGFloat(cos(angle) * hypotenuse),
                                 y: center.y + CGFloat(sin(angle) * hypotenuse))

            if i == 0 {
                path.move(to: vertex) // move to first vertex
            } else {
                path.addLine(to: vertex) // draw line to next vertex
            }
        }

        path.closeSubpath()

        return path
    }
}

// MARK: - Previews

#Preview {
    Polygon(sides: 10)
        .fill(.red)
        .aspectRatio(contentMode: .fit)
}

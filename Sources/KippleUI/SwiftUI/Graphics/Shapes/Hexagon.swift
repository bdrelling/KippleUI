// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct Hexagon: Shape {
    public enum Orientation: Sendable {
        /// Flat sides on top and bottom edges.
        case horizontal

        /// Flat sides on leading and trailing edges.
        case vertical
    }

    private let orientation: Orientation

    private var angle: Angle {
        .degrees(self.orientation == .horizontal ? 30 : 0)
    }

    public init(orientation: Orientation = .horizontal) {
        self.orientation = orientation
    }

    public func path(in rect: CGRect) -> Path {
        PointedStar(corners: 3, smoothness: 1)
            .rotation(self.angle)
            .path(in: rect)
    }
}

// MARK: - Previews

#Preview {
    VStack {
        Hexagon(orientation: .horizontal)
            .fill(.red)
            .aspectRatio(contentMode: .fit)

        Hexagon(orientation: .vertical)
            .fill(.red)
            .aspectRatio(contentMode: .fit)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .init(x: rect.midX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: rect.minY))

        return path
    }

    public init() {}
}

// MARK: - Previews

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle()
            .fill(.blue)
            .aspectRatio(1, contentMode: .fit)
    }
}

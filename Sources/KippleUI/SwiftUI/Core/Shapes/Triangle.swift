// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.midX, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX, y: rect.minY))

        return path
    }

    public init() {}
}

// MARK: - Previews

struct Triangle_Previews: PreviewProvider {
    static let caption: String = "And here's a caption with some more fancy info, like '\(UUID().uuidString)'."

    static var previews: some View {
        Triangle()
            .fill(.blue)
            .frame(width: 100, height: 100)
    }
}

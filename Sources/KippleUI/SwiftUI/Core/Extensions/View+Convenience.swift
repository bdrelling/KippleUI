// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    func flippedHorizontally() -> some View {
        self.scaleEffect(x: -1)
    }

    func flippedVertically() -> some View {
        self.scaleEffect(y: -1)
    }

    @ViewBuilder
    func frame(size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }

    func offset(_ offset: CGPoint) -> some View {
        self.offset(x: offset.x, y: offset.y)
    }

    @ViewBuilder
    func previewDisplayNameIfNotNil(_ value: String?) -> some View {
        if let value = value {
            self.previewDisplayName(value)
        } else {
            self
        }
    }
}

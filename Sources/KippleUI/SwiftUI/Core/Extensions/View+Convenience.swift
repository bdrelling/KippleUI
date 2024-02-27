// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    func flippedHorizontally() -> some View {
        scaleEffect(x: -1)
    }

    func flippedVertically() -> some View {
        scaleEffect(y: -1)
    }

    @ViewBuilder
    func frame(size: CGSize?) -> some View {
        self.frame(width: size?.width, height: size?.height)
    }

    func offset(_ offset: CGPoint?) -> some View {
        self.offset(
            x: offset?.x ?? 0,
            y: offset?.y ?? 0
        )
    }

    @ViewBuilder
    func previewDisplayNameIfNotNil(_ value: String?) -> some View {
        if let value = value {
            previewDisplayName(value)
        } else {
            self
        }
    }
}

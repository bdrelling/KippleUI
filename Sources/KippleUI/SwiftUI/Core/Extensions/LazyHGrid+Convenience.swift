// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension LazyHGrid {
    init(
        rows: Int,
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            rows: Array(repeating: .init(.flexible()), count: rows),
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

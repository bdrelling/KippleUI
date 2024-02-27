// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

@available(macOS 13.0, *)
public extension LazyHGrid {
    init(
        rows: Int,
        gridItem: GridItem = .init(.flexible()),
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            rows: Array(repeating: gridItem, count: rows),
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }

    init(
        rows: Int,
        gridItemSize _: GridItem.Size = .flexible(),
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        verticalSpacing: CGFloat,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            rows: rows,
            gridItem: .init(.flexible(), spacing: verticalSpacing),
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

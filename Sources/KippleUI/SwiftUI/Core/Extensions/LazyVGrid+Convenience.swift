// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 14.0, macOS 13.0, *)
public extension LazyVGrid {
    init(
        columns: Int,
        gridItem: GridItem = .init(.flexible()),
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            columns: Array(repeating: gridItem, count: columns),
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
    
    init(
        columns: Int,
        gridItemSize: GridItem.Size = .flexible(),
        alignment: HorizontalAlignment = .center,
        verticalSpacing: CGFloat? = nil,
        horizontalSpacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            columns: columns,
            gridItem: .init(.flexible(), spacing: horizontalSpacing),
            alignment: alignment,
            spacing: verticalSpacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 14.0, macOS 13.0, *)
public extension LazyVGrid {
    init(
        columns: Int,
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            columns: Array(repeating: .init(.flexible()), count: columns),
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

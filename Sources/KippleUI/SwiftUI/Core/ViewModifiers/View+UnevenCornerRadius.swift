// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension View {
    @ViewBuilder
    func unevenCornerRadius(_ radii: RectangleCornerRadii, style: RoundedCornerStyle = .circular) -> some View {
        self.clipShape(UnevenRoundedRectangle(cornerRadii: radii, style: style))
    }

    @ViewBuilder
    func unevenCornerRadius(
        topLeading: CGFloat,
        bottomLeading: CGFloat,
        bottomTrailing: CGFloat,
        topTrailing: CGFloat,
        style: RoundedCornerStyle = .circular
    ) -> some View {
        self.unevenCornerRadius(
            .init(
                topLeading: topLeading,
                bottomLeading: bottomLeading,
                bottomTrailing: bottomTrailing,
                topTrailing: topTrailing
            ),
            style: style
        )
    }
}

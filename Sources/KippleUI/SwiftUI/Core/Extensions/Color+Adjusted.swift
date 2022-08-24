// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension Color {
    func lighter(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage))
    }

    func darker(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    func adjusted(byPercentage percentage: CGFloat) -> Color {
        Color(UXColor(self).adjusted(byPercentage: percentage))
    }
}

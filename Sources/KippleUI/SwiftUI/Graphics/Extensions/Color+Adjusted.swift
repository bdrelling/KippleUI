// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

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

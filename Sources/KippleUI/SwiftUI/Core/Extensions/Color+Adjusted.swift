// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension Color {
    func lighter(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage))
    }

    func darker(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    func adjusted(byPercentage percentage: CGFloat) -> Color {
        Color(NativeColor(self).adjusted(byPercentage: percentage))
    }
}

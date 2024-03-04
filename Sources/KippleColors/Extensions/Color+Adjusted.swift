// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

// TODO: Create previews or delete
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

// MARK: - UIKit / AppKit Extensions

public extension UXColor {
    func lighter(byPercentage percentage: CGFloat) -> Self {
        self.adjusted(byPercentage: abs(percentage))
    }

    func darker(byPercentage percentage: CGFloat) -> Self {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    func adjusted(byPercentage percentage: CGFloat) -> Self {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return .init(
            red: min(red + percentage / 100, 1.0),
            green: min(green + percentage / 100, 1.0),
            blue: min(blue + percentage / 100, 1.0),
            alpha: alpha
        )
    }
}

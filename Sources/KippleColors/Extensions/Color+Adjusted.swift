// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Extension to provide methods for adjusting the brightness of colors.
public extension Color {
    /// Returns a lighter version of the color by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to lighten the color.
    /// - Returns: A lighter version of the color.
    func lighter(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage))
    }

    /// Returns a darker version of the color by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to darken the color.
    /// - Returns: A darker version of the color.
    func darker(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    /// Returns a version of the color adjusted by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to adjust the color brightness.
    /// - Returns: An adjusted version of the color.
    func adjusted(byPercentage percentage: CGFloat) -> Color {
        Color(UXColor(self).adjusted(byPercentage: percentage))
    }
}

// MARK: - UIKit / AppKit Extensions

public extension UXColor {
    /// Returns a lighter version of the color by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to lighten the color.
    /// - Returns: A lighter version of the color.
    func lighter(byPercentage percentage: CGFloat) -> Self {
        self.adjusted(byPercentage: abs(percentage))
    }

    /// Returns a darker version of the color by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to darken the color.
    /// - Returns: A darker version of the color.
    func darker(byPercentage percentage: CGFloat) -> Self {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    /// Returns a version of the color adjusted by the specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to adjust the color brightness.
    /// - Returns: An adjusted version of the color.
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

// MARK: - Previews

// TODO: Build previesws! Not working at time of writing
#Preview {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo]
    let percentages: [CGFloat] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

    return Group {
        VStack(spacing: 0) {
            ForEach(colors, id: \.self) { color in
                HStack(spacing: 0) {
                    ForEach(percentages.reversed(), id: \.self) { percentage in
                        color.darker(byPercentage: percentage)
                    }

                    color

                    ForEach(percentages, id: \.self) { percentage in
                        color.lighter(byPercentage: percentage)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 16) {
        Color(hex: 0x000000)
        Color(hex: 0xFF0000)
        Color(hex: 0x00FF00)
        Color(hex: 0x0000FF)
        Color(hex: 0xFFFFFF)
    }
    .padding()
    .background(.purple)
}

// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)
    import UIKit

    public typealias NativeColor = UIColor
#elseif canImport(AppKit)
    import AppKit

    public typealias NativeColor = NSColor
#endif

public extension NativeColor {
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

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return .init(
            red: min(red + percentage / 100, 1.0),
            green: min(green + percentage / 100, 1.0),
            blue: min(blue + percentage / 100, 1.0),
            alpha: alpha
        )
    }
}

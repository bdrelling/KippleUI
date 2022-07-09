// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

    import SwiftUI

    // source: https://stackoverflow.com/questions/56726869/is-it-possible-to-use-dynamic-type-sizes-with-a-custom-font-in-swiftui

    public struct CustomRelativeFont: ViewModifier {
        @Environment(\.sizeCategory) var sizeCategory

        public var name: String
        public var style: UIFont.TextStyle
        public var weight: Font.Weight = .regular

        public func body(content: Content) -> some View {
            if #available(iOS 14.0, *) {
                return content.font(
                    Font.custom(self.name, size: UIFont.preferredFont(forTextStyle: self.style).pointSize)
                        .weight(self.weight)
                )
            } else {
                return content.font(
                    Font.custom(self.name, size: UIFont.preferredFont(forTextStyle: self.style).pointSize)
                        .weight(self.weight)
                )
            }
        }
    }

    // source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font

    public struct CustomScaledFont: ViewModifier {
        @Environment(\.sizeCategory) var sizeCategory

        public var name: String
        public var size: CGFloat
        public var weight: Font.Weight = .regular

        public func body(content: Content) -> some View {
            let scaledSize = UIFontMetrics.default.scaledValue(for: self.size)

            return content.font(
                Font.custom(self.name, size: scaledSize)
                    .weight(self.weight)
            )
        }
    }

    public struct CustomStaticFont: ViewModifier {
        public var name: String
        public var size: CGFloat
        public var weight: Font.Weight = .regular

        public func body(content: Content) -> some View {
            content.font(
                Font.custom(self.name, size: self.size)
                    .weight(self.weight)
            )
        }
    }

    // MARK: - Extensions

    public extension View {
        func customFont(name: String,
                        style: UIFont.TextStyle,
                        weight: Font.Weight = .regular) -> some View {
            self.modifier(CustomRelativeFont(name: name, style: style, weight: weight))
        }

        func customFont(name: String, size: CGFloat, weight: Font.Weight = .regular) -> some View {
            self.modifier(CustomStaticFont(name: name, size: size, weight: weight))
        }
    }

    public extension View {
        func scaledFont(name: String, size: CGFloat, weight: Font.Weight = .regular) -> some View {
            self.modifier(CustomScaledFont(name: name, size: size, weight: weight))
        }
    }

    // MARK: - Convenience

    public struct AppFont: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }

    extension AppFont: ExpressibleByStringLiteral {
        public init(stringLiteral: String) {
            self = AppFont(rawValue: stringLiteral)
        }
    }

    public extension View {
        func customFont(_ appFont: AppFont,
                        style: UIFont.TextStyle,
                        weight: Font.Weight = .regular) -> some View {
            self.customFont(name: appFont.rawValue, style: style, weight: weight)
        }

        func customFont(_ appFont: AppFont,
                        size: CGFloat,
                        weight: Font.Weight = .regular) -> some View {
            self.customFont(name: appFont.rawValue, size: size, weight: weight)
        }
    }

    public extension View {
        func scaledFont(_ appFont: AppFont,
                        size: CGFloat,
                        weight: Font.Weight = .regular) -> some View {
            self.scaledFont(name: appFont.rawValue, size: size, weight: weight)
        }
    }

#endif

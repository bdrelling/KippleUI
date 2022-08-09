// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public protocol KipplePickerStyle {
    var itemVerticalSpacing: CGFloat { get }
    var itemHorizontalSpacing: CGFloat { get }
}

// MARK: - Supporting Types

public struct DefaultKipplePickerStyle: KipplePickerStyle {
    public let itemVerticalSpacing: CGFloat = 0
    public let itemHorizontalSpacing: CGFloat = 0
}

extension KipplePickerStyle where Self == DefaultKipplePickerStyle {
    static var `default`: Self { .init() }
}

private struct KipplePickerStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: KipplePickerStyle = .default
}

public extension EnvironmentValues {
    var kipplePickerStyle: KipplePickerStyle {
        get { self[KipplePickerStyleEnvironmentKey.self] }
        set { self[KipplePickerStyleEnvironmentKey.self] = newValue }
    }
}

// MARK: - Extensions

public extension View {
    func kipplePickerStyle(_ style: KipplePickerStyle) -> some View {
        self.environment(\.kipplePickerStyle, style)
    }
}

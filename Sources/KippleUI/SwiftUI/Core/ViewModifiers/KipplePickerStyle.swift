// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public protocol KipplePickerStyle {
    var verticalSpacing: CGFloat { get }
    var horizontalSpacing: CGFloat { get }
}

// MARK: - Supporting Types

public struct DefaultKipplePickerStyle: KipplePickerStyle {
    public let verticalSpacing: CGFloat = 0
    public let horizontalSpacing: CGFloat = 0
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
        environment(\.kipplePickerStyle, style)
    }
}

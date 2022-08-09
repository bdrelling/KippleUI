// Copyright © 2022 Brian Drelling. All rights reserved.

// import SwiftUI
//
// public protocol KipplePickerItemStyle {
//    var buttonStyle: (any ButtonStyle)? { get }
// }
//
//// MARK: - Supporting Types
//
// public struct DefaultKipplePickerItemStyle: KipplePickerItemStyle {
//    public let buttonStyle: (any ButtonStyle)? = nil
// }
//
// extension KipplePickerItemStyle where Self == DefaultKipplePickerItemStyle {
//    static var `default`: Self { .init() }
// }
//
// private struct KipplePickerItemStyleEnvironmentKey: EnvironmentKey {
//    static let defaultValue: KipplePickerItemStyle = .default
// }
//
// public extension EnvironmentValues {
//    var kipplePickerItemStyle: KipplePickerItemStyle {
//        get { self[KipplePickerItemStyleEnvironmentKey.self] }
//        set { self[KipplePickerItemStyleEnvironmentKey.self] = newValue }
//    }
// }
//
//// MARK: - Extensions
//
// public extension View {
//    func kipplePickerItemStyle(_ style: KipplePickerItemStyle) -> some View {
//        self.environment(\.kipplePickerItemStyle, style)
//    }
// }

// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public protocol StateEnabledButtonStyle: ButtonStyle {
    associatedtype Content: View

    /// Whether or not the button is currently enabled.
    /// Should be implemented as `@Environment(\.isEnabled) var isEnabled: Bool`.
    var isEnabled: Bool { get }

    #if DEBUG
        /// Whether or not the button has a state override,
        /// which is useful for SwiftUI previews.
        var previewState: ButtonState? { get }
    #endif

    @ViewBuilder
    func makeBody(label: ButtonStyleConfiguration.Label, state: ButtonState) -> Self.Content
}

public enum ButtonState {
    case enabled
    case pressed
    case disabled
}

public extension StateEnabledButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        let state = self.state(for: configuration)

        return self.makeBody(label: configuration.label, state: state)
    }

    func state(for configuration: Configuration) -> ButtonState {
        #if DEBUG

            if let previewState = self.previewState {
                return previewState
            }

        #endif

        if !self.isEnabled {
            return .disabled
        } else if configuration.isPressed {
            return .pressed
        } else {
            return .enabled
        }
    }
}

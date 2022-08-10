// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// This enum represents both a destination target (`Screen`) and its navigation method,
/// including any associated params: e.g., screens that should be presented via `sheet` also
/// require parameters specifying whether or not its content should be embedded in a
/// `NavigationView` and an optional `onDismiss` handler.
///
/// - Note: Heavily influenced by [this excellent blog post](https://johnpatrickmorgan.github.io/2021/07/03/NStack/).
public enum NavigationRoute<Screen: Equatable> {
    /// A `Screen` to be navigated via push (`NavigationLink`)
    case push(Screen)

    /// A `Screen` to be navigated via `sheet`
    /// - parameter screen: the `Screen` to be navigated to.
    /// - parameter inNavigation: whether or not the `Screen` should be embedded in a
    /// `NavigationView` — defaults to `true`.
    /// - parameter onDismiss: optional completion handler to be called upon dismissing
    ///  the sheet — defaults to `nil`.
    case present(Screen, inNavigation: Bool = true, onDismiss: (() -> Void)? = nil)

    /// The `Screen` to set as the root view of any `ScreenStack`.
    case root(Screen)

    /// The `Screen` associated with/represented by the given case.
    public var screen: Screen {
        get {
            switch self {
            case let .push(screen), let .present(screen, _, _), let .root(screen):
                return screen
            }
        }
        set {
            switch self {
            case .push:
                self = .push(newValue)
            case let .present(_, inNavigation, onDismiss):
                self = .present(newValue, inNavigation: inNavigation, onDismiss: onDismiss)
            case let .root(screen):
                self = .root(screen)
            }
        }
    }

    /// Whether or not the associated view should be presented inside a navigation view.
    /// - Note: only applies to `present` cases, since `push` cases will be
    /// pushed on top of/within the same navigation view.
    public var inNavigation: Bool {
        switch self {
        case let .present(_, inNavigation, _):
            return inNavigation
        case .root:
            return true
        default:
            return false
        }
    }

    /// Whether or not the associated view is presented modally/in a sheet.
    public var isPresented: Bool {
        switch self {
        case .push, .root:
            return false
        case .present:
            return true
        }
    }

    /// Whether or not the current instance represents the root screen.
    var isRoot: Bool {
        switch self {
        case .root:
            return true
        case .push, .present:
            return false
        }
    }
}

// MARK: Equatable

extension NavigationRoute: Equatable where Screen: Equatable {
    public static func == (lhs: NavigationRoute, rhs: NavigationRoute) -> Bool {
        lhs.isPresented == rhs.isPresented && lhs.screen == rhs.screen
    }
}

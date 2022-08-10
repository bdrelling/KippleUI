// Copyright © 2022 Brian Drelling. All rights reserved.

// import Foundation

public enum ScreenPosition<Screen: Equatable> {
    case root(Screen)
    case screen(Screen, _ index: Int)

    var isRoot: Bool {
        switch self {
        case .root:
            return true
        case .screen:
            return false
        }
    }

    var screen: Screen {
        switch self {
        case let .root(screen), let .screen(screen, _):
            return screen
        }
    }
}

// MARK: Equatable

extension ScreenPosition: Equatable {}

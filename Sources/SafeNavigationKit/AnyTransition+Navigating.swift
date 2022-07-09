// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension AnyTransition {
    static func navigating(_ direction: NavigationDirection) -> AnyTransition {
        switch direction {
        case .forward:
            return .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
        case .back:
            return .asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            )
        }
    }
}

// MARK: - Supporting Types

public enum NavigationDirection {
    case forward
    case back

    var opposite: Self {
        switch self {
        case .forward:
            return .back
        case .back:
            return .forward
        }
    }
}

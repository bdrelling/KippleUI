// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension LinearGradient {
    static func fading(
        _ color: Color,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> Self {
        .init(colors: [
            color,
            color.opacity(0),
        ], startPoint: .top, endPoint: .bottom)
    }
}

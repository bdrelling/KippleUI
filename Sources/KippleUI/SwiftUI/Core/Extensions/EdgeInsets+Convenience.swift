// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension EdgeInsets {
    static let zero: Self = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

    static func square(_ value: CGFloat) -> Self {
        .init(top: value, leading: value, bottom: value, trailing: value)
    }
}

// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension CGRect {
    var center: CGPoint {
        .init(x: self.midX, y: self.midY)
    }
}

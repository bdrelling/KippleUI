// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func navigationHidden(_ isHidden: Bool = true) -> some View {
        #if os(macOS)
        self
        #else
        self
            .navigationBarHidden(isHidden)
            .navigationBarBackButtonHidden(isHidden)
        #endif
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

#if os(macOS)

public enum PlatformSafeTitleDisplayMode {
    case automatic
    case inline

    @available(tvOS, unavailable)
    case large
}

@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public extension View {
    func navigationBarTitleDisplayMode(_ mode: PlatformSafeTitleDisplayMode) -> some View {
        self
    }
}

#endif

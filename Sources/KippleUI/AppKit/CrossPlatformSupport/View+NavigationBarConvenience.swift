// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

#if os(macOS) || os(tvOS) || os(watchOS)
public enum PlatformSafeTitleDisplayMode {
    case automatic
    case inline

    @available(tvOS, unavailable)
    case large
}
#endif

#if os(macOS)

public extension View {
    func navigationBarTitleDisplayMode(_: PlatformSafeTitleDisplayMode) -> some View {
        self
    }
}

#endif

#if os(tvOS) || os(watchOS)

extension View {
    public func navigationBarTitle(_ titleKey: LocalizedStringKey, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self.navigationTitle(titleKey)
    }
}

#endif

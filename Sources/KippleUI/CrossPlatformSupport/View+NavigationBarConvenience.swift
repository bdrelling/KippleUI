// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public enum PlatformSafeTitleDisplayMode {
    case automatic
    case inline

    @available(tvOS, unavailable)
    case large

    #if !os(macOS)
    var rawValue: NavigationBarItem.TitleDisplayMode {
        switch self {
        case .automatic: .automatic
        case .inline: .inline

        #if !os(tvOS)
        case .large: .large
        #endif
        }
    }
    #endif
}

public extension View {
    func crossPlatformNavigationBarTitleDisplayMode(_ mode: PlatformSafeTitleDisplayMode) -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(mode.rawValue)
        #endif
    }
}

#if os(tvOS) || os(watchOS)

public extension View {
    func navigationBarTitle(_ titleKey: LocalizedStringKey, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self.navigationTitle(titleKey)
    }
}

#endif

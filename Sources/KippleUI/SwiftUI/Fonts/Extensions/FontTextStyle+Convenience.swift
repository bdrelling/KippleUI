// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

public extension Font.TextStyle {
    var uiTextStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle:
            #if os(tvOS)
            // There is no .largeTitle on tvOS, so we leverage .title1 instead.
            return .title1
            #else
            return .largeTitle
            #endif
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        @unknown default:
            return .body
        }
    }

    var preferredSize: CGFloat {
        self.uiTextStyle.preferredSize
    }
}

#endif

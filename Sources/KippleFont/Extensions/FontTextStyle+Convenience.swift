// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font.TextStyle {
    var uxTextStyle: UXFont.TextStyle {
        UXFont.TextStyle(textStyle: self)
    }

    var preferredSize: CGFloat {
        self.uxTextStyle.preferredSize
    }
}

// MARK: - UIKit / AppKit Extensions

#if canImport(UIKit)

extension UIFont.TextStyle {
    init(textStyle: Font.TextStyle) {
        switch textStyle {
        case .largeTitle:
            #if os(tvOS)
            // There is no .largeTitle on tvOS, so we leverage .title1 instead.
            self = .title1
            #else
            self = .largeTitle
            #endif
        case .title:
            self = .title1
        case .title2:
            self = .title2
        case .title3:
            self = .title3
        case .headline:
            self = .headline
        case .subheadline:
            self = .subheadline
        case .body:
            self = .body
        case .callout:
            self = .callout
        case .footnote:
            self = .footnote
        case .caption:
            self = .caption1
        case .caption2:
            self = .caption2
        @unknown default:
            self = .body
        }
    }

    var preferredSize: CGFloat {
        UIFont.preferredFont(forTextStyle: self).pointSize
    }
}

#elseif canImport(AppKit)

extension NSFont.TextStyle {
    init(textStyle: Font.TextStyle) {
        switch textStyle {
        case .largeTitle:
            self = .largeTitle
        case .title:
            self = .title1
        case .title2:
            self = .title2
        case .title3:
            self = .title3
        case .headline:
            self = .headline
        case .subheadline:
            self = .subheadline
        case .body:
            self = .body
        case .callout:
            self = .callout
        case .footnote:
            self = .footnote
        case .caption:
            self = .caption1
        case .caption2:
            self = .caption2
        @unknown default:
            self = .body
        }
    }

    var preferredSize: CGFloat {
        NSFont.preferredFont(forTextStyle: self).pointSize
    }
}

#endif

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

#if os(iOS)

import Foundation

public extension View {
    private func performHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }

    func impactFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light, isEnabled: Bool = true) -> some View {
        onTapGesture {
            if isEnabled {
                self.performHapticFeedback(style: style)
            }
        }
    }

    func simultaneousImpactFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light, isEnabled: Bool = true) -> some View {
        simultaneousGesture(TapGesture().onEnded { _ in
            if isEnabled {
                self.performHapticFeedback(style: style)
            }
        })
    }

    func simultaneousSelectionFeedback(isEnabled: Bool = true) -> some View {
        simultaneousGesture(TapGesture().onEnded { _ in
            if isEnabled {
                UISelectionFeedbackGenerator().selectionChanged()
            }
        })
    }
}

#else

// Source: https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle
public enum PlatformSafeFeedbackStyle {
    case heavy
    case light
    case medium
    case rigid
    case soft
}

public extension View {
    func impactFeedbackOnTap(style _: PlatformSafeFeedbackStyle = .light, isEnabled _: Bool = true) -> some View {
        // do nothing -- haptic feedback is not supported on other platforms
        self
    }

    func simultaneousImpactFeedbackOnTap(style _: PlatformSafeFeedbackStyle = .light, isEnabled _: Bool = true) -> some View {
        // do nothing -- haptic feedback is not supported on other platforms
        self
    }

    func simultaneousSelectionFeedback(isEnabled _: Bool = true) -> some View {
        // do nothing -- haptic feedback is not supported on other platforms
        self
    }
}

#endif

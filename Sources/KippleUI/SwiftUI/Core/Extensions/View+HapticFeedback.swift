// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

    import Foundation
    import SwiftUI

    public extension View {
        private func performHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }

        func impactFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light, isEnabled: Bool = true) -> some View {
            self.onTapGesture {
                if isEnabled {
                    self.performHapticFeedback(style: style)
                }
            }
        }

        func simultaneousImpactFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light, isEnabled: Bool = true) -> some View {
            self.simultaneousGesture(TapGesture().onEnded { _ in
                if isEnabled {
                    self.performHapticFeedback(style: style)
                }
            })
        }

        func simultaneousSelectionFeedback(isEnabled: Bool = true) -> some View {
            self.simultaneousGesture(TapGesture().onEnded { _ in
                if isEnabled {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
            })
        }
    }

#endif

// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

#if canImport(UIKit) && !os(watchOS)

public struct VisualEffectView: UIViewRepresentable {
    private let effect: UIVisualEffect?

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = self.effect }

    public init(effect: UIVisualEffect?) {
        self.effect = effect
    }

    public init(blur style: UIBlurEffect.Style) {
        self.init(effect: UIBlurEffect(style: style))
    }
}

#elseif os(macOS)

@available(macOS 12.0, *)
public struct VisualEffectView: View {
    public var body: some View {
        Rectangle()
            .fill(.regularMaterial)
    }
}

#endif

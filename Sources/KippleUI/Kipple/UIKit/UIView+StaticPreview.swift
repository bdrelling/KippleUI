// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct UIViewPreview: UIViewRepresentable {
    private let view: UIView

    init(_ view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func makeUIView(context: Context) -> UIView {
        self.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - Extensions

public extension UIView {
    func staticPreview() -> some View {
        UIViewPreview(self)
    }
}

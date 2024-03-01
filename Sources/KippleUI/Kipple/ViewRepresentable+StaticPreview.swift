// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit) && (os(iOS) || os(tvOS))

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

#elseif canImport(AppKit)

import SwiftUI

private struct UIViewPreview: NSViewRepresentable {
    private let view: NSView

    init(_ view: NSView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func makeNSView(context: Context) -> NSView {
        self.view
    }

    func updateNSView(_ uiView: NSView, context: Context) {}
}

// MARK: - Extensions

public extension NSView {
    func staticPreview() -> some View {
        UIViewPreview(self)
    }
}

#endif

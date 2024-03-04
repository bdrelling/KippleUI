// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Mocks a `View` being presented as `sheet` for Xcode Previews.
private struct SheetPreviewer<Content>: View where Content: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    public let content: () -> Content

    @State var isPresented: Bool = true

    public var body: some View {
        Color.blue
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: self.$isPresented) {
                self.content()
                    .dynamicTypeSize(self.dynamicTypeSize)
            }
            .onChange(of: self.isPresented) { _, newValue in
                if newValue == false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isPresented = true
                    }
                }
            }
    }

    public init(@ViewBuilder _ content: @escaping (() -> Content)) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    /// Mocks a `View` being presented as `sheet` for Xcode Previews.
    func previewAsSheet() -> some View {
        SheetPreviewer {
            self
        }
    }
}

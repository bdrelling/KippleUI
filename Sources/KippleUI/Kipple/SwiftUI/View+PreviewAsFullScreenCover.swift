// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Mocks a `View` being presented as `fullScreenCover` for Xcode Previews.
private struct FullScreenCoverPreviewer<Content>: View where Content: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    public let content: () -> Content

    @State var isPresented: Bool = true

    public var body: some View {
        Color.blue
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: self.$isPresented) {
                self.content()
                    .dynamicTypeSize(self.dynamicTypeSize)
            }
            .onChange(of: self.isPresented) { newValue in
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
    /// Mocks a `View` being presented as `fullScreenCover` for Xcode Previews.
    func previewAsFullScreenCover() -> some View {
        FullScreenCoverPreviewer {
            self
        }
    }
}

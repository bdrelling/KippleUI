// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct ModalPreviewer<Content>: View where Content: View {
    public let content: () -> Content

    public var body: some View {
        Color.blue
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: .constant(true)) {
                self.content()
            }
    }

    public init(@ViewBuilder _ content: @escaping (() -> Content)) {
        self.content = content
    }
}

// MARK: - Extensions

public extension View {
    func previewInModal() -> some View {
        ModalPreviewer {
            self
        }
    }
}

// MARK: - Previews

struct ModalPreviewer_Previews: PreviewProvider {
    static var previews: some View {
        Text("This is a modal!")
            .previewInModal()
            .previewMatrix()
    }
}

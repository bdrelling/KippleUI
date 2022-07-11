// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct ModalPreviewer<Content>: View where Content: View {
    let content: () -> Content

    var body: some View {
        Color.blue
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: .constant(true)) {
                self.content()
            }
    }

    init(@ViewBuilder _ content: @escaping (() -> Content)) {
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
    @State private var isPresenting = false

    static var previews: some View {
        Text("This is a modal!")
            .previewInModal()
            .previewMatrix()
    }
}

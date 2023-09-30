// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    func snapshot() -> Image {
        .init(uiImage: self.uiImage())
    }

    func uiImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

// MARK: - Previews

struct ViewSnapshot_Previews: PreviewProvider {
    static var previews: some View {
        Text("Wow")
            .foregroundColor(.purple)
            .padding()
            .frame(width: 200, height: 200)
            .background(Color.yellow)
            .snapshot()
    }
}

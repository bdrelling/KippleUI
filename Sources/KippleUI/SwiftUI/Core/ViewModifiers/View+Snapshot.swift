// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

#if canImport(UIKit) && (os(iOS) || os(tvOS))

public extension View {
    func snapshot() -> Image {
        .init(uiImage: self.uiImage())
    }

    private func uiImage() -> UIImage {
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

#else

public extension View {
    func snapshot() -> Image {
        print("WARNING: View.snapshot() is only available on iOS and tvOS.")
        return .init(systemName: "photo")
    }
}

#endif

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

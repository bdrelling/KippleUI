// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: () -> Void

    public init(perform action: @escaping () -> Void) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        content.onAppear {
            if self.didLoad == false {
                self.didLoad = true
                self.action()
            }
        }
    }
}

// MARK: - Extensions

public extension View {
    func onLoad(perform action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

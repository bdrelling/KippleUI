// Copyright © 2022 Brian Drelling. All rights reserved.

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

public extension View {
    func onLoad(perform action: @escaping () -> Void) -> some View {
        self.modifier(ViewDidLoadModifier(perform: action))
    }
}

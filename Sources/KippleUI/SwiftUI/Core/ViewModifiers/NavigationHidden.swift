// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

@available(macOS, unavailable)
public struct NavigationHidden: ViewModifier {
    public func body(content: Content) -> some View {
        // FIXME: It's absurd that this is required, but the unavailable attribute is not being respected.
        if #available(macOS 13.0, *) {
            content
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

@available(macOS, unavailable)
public extension View {
    func navigationHidden() -> some View {
        self.modifier(NavigationHidden())
    }
}

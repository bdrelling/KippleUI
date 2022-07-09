// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

@available(macOS, unavailable)
public struct NavigationHidden: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

@available(macOS, unavailable)
public extension View {
    func navigationHidden() -> some View {
        self.modifier(NavigationHidden())
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

#if !os(macOS)

import Foundation
import SwiftUI

public struct NavigationHidden: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

public extension View {
    func navigationHidden() -> some View {
        modifier(NavigationHidden())
    }
}

#endif

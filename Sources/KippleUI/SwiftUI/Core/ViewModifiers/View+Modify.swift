// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension View {
    @ViewBuilder
    func modify<Content>(_ content: @escaping (Self) -> Content) -> some View where Content: View {
        content(self)
    }
}

// MARK: - Previews

struct View_Modify_Previews: PreviewProvider {
    static var previews: some View {
        Color.blue
            .modify { view in
                #if os(iOS)
                view.overlay {
                    Text("iOS")
                }
                #else
                view.overlay {
                    Text("Not iOS!")
                }
                #endif
            }
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

#if canImport(UIKit)

extension View {
    @ViewBuilder
    func font(_ font: UIFont) -> some View {
        self.font(.custom(font.familyName, size: font.pointSize))
    }
}

#elseif canImport(AppKit)

extension View {
    @ViewBuilder
    func font(_ font: NSFont) -> some View {
        if let familyName = font.familyName {
            self.font(.custom(familyName, size: font.pointSize))
        } else {
            self
        }
    }
}

#endif

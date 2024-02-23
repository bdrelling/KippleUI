// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

extension View {
    func font(_ font: UIFont) -> some View {
        self.font(.custom(font.familyName, size: font.pointSize))
    }
}

#endif

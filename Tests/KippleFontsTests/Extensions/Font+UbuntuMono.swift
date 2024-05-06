// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import KippleFonts
import SwiftUI

extension Font {
    struct UbuntuMono {
        let body: Font = .ubuntuMono(.body)

        fileprivate init() {
            try? FontManager.shared.registerFonts(in: .module)
        }
    }
}

// MARK: - Supporting Types

extension UXFont {
    struct UbuntuMono {
        let body: UXFont = .ubuntuMono(.body)

        fileprivate init() {
            try? FontManager.shared.registerFonts(in: .module)
        }
    }
}

// MARK: - Extensions

extension Font {
    static let ubuntuMono = UbuntuMono()
}

extension UXFont {
    static let ubuntuMono = UbuntuMono()
}

private extension RegisteredFontName {
    static let ubuntuMono: Self = "Ubuntu Mono"
}

private extension Font {
    static func ubuntuMono(_ style: TextStyle = .body) -> Self {
        self.custom(.ubuntuMono, relativeTo: style)
    }

    static func ubuntuMono(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
        self.custom(.ubuntuMono, size: size, relativeTo: style)
    }
}

private extension UXFont {
    static func ubuntuMono(_ style: TextStyle = .body) -> UXFont {
        self.custom(.ubuntuMono, relativeTo: style)
    }

//    static func ubuntuMono(size: CGFloat, relativeTo style: TextStyle = .body) -> Self {
//        self.custom(.ubuntuMono, size: size, relativeTo: style)
//    }
}

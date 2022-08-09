// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import SwiftUI

struct SystemFont_Previews: PreviewProvider {
    private static var allFonts: [SystemFont] = [
        .init("Title", .title),
        .init("Title 2", .title2),
        .init("Title 3", .title3),
    ]

    static var previews: some View {
        VStack {
            ForEach(self.allFonts) { font in
                Text("The quick brown fox jumps over the lazy dog.")
                    .font(font.font)
            }
        }
        .previewMatrix(.sizeThatFits)
    }
}

// MARK: - Supporting Types

private struct SystemFont {
    let name: String
    let font: Font

    init(_ name: String, _ font: Font) {
        self.name = name
        self.font = font
    }
}

// MARK: - Extensions

extension SystemFont: Identifiable {
    var id: String {
        self.name
    }
}

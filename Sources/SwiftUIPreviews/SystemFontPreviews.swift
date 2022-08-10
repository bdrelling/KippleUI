// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import SwiftUI

/// Displays all standard system font types for easy reference.
/// For more references, see:
/// - https://developer.apple.com/documentation/swiftui/font
/// - https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
struct SystemFont_Previews: PreviewProvider {
    private static let pangram = "How vexingly quick daft zebras jump!"

    private static var allFonts: [SystemFont] = [
        .init("Large Title", .largeTitle),
        .init("Title", .title),
        .init("Title 2", .title2),
        .init("Title 3", .title3),
        .init("Headline", .headline),
        .init("Subheadline", .subheadline),
        .init("Body", .body),
        .init("Callout", .callout),
        .init("Caption", .caption),
        .init("Caption 2", .caption2),
        .init("Footnote", .footnote),
    ]

    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(self.allFonts) { font in
                VStack(alignment: .leading, spacing: 4) {
                    Text(font.name)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(self.pangram)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(font.font)
                }
            }
        }
        .padding(.horizontal)
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

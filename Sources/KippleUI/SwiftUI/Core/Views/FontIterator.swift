// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

/// Iterates through all standard system font types for easy reference.
/// For more references, see:
/// - https://developer.apple.com/documentation/swiftui/font
/// - https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
public struct FontIterator<Content>: View where Content: View {
    private let fonts: [Font]
    private let content: (Font) -> Content

    public var body: some View {
        ForEach(self.fonts) { font in
            self.content(font)
        }
    }

    init(
        fonts: [Font] = Font.allCases,
        @ViewBuilder _ content: @escaping (Font) -> Content
    ) {
        self.fonts = fonts
        self.content = content
    }
}

// MARK: - Previews

struct FontIterator_Previews: PreviewProvider {
    private static let pangram = "How vexingly quick daft zebras jump!"

    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            FontIterator { font in
                VStack(alignment: .leading) {
                    Text(font.name)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(self.pangram)
                        .font(font)
                }
            }
        }
        .padding()
        .previewMatrix(.sizeThatFits)
    }
}

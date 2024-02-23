// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Iterates through all standard system font types for easy reference.
/// For more references, see:
/// - https://developer.apple.com/documentation/swiftui/font
/// - https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
public struct SystemFontIterator<Content>: View where Content: View {
    private let textStyles: [Font.TextStyle]
    private let content: (Font, Font.TextStyle) -> Content

    public var body: some View {
        TextStyleIterator(self.textStyles) { textStyle in
            self.content(.system(textStyle), textStyle)
        }
    }

    public init(
        _ textStyles: [Font.TextStyle] = Font.TextStyle.allCases,
        @ViewBuilder _ content: @escaping (Font, Font.TextStyle) -> Content
    ) {
        self.textStyles = textStyles
        self.content = content
    }
}

// MARK: - Previews

struct SystemFontIterator_Previews: PreviewProvider {
    private static let pangram = "How vexingly quick daft zebras jump!"

    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            SystemFontIterator { font, textStyle in
                VStack(alignment: .leading) {
                    Text(String(describing: textStyle))
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(self.pangram)
                        .font(font)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .previewMatrix(.sizeThatFits)
    }
}

// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

/// Iterates through all standard system text styles for easy reference.
/// For more references, see:
/// - https://developer.apple.com/documentation/swiftui/font
/// - https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
public struct TextStyleIterator<Content>: View where Content: View {
    private let textStyles: [Font.TextStyle]
    private let content: (Font.TextStyle) -> Content

    public var body: some View {
        ForEach(self.textStyles, id: \.self) { textStyle in
            self.content(textStyle)
        }
    }

    public init(
        _ textStyles: [Font.TextStyle] = Font.TextStyle.allCases,
        @ViewBuilder _ content: @escaping (Font.TextStyle) -> Content
    ) {
        self.textStyles = textStyles
        self.content = content
    }
}

// MARK: - Previews

struct TextStyleIterator_Previews: PreviewProvider {
    static var previews: some View {
        // Previews for this iterator would just use the system font for demonstration.
        // As such, just re-purpose the SystemFontIterator previews.
        SystemFontIterator_Previews.previews
    }
}

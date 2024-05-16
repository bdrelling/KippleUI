// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct FontIterator<Content>: View where Content: View {
    private let fonts: [UXFont]
    private let content: (Font, String) -> Content

    public var body: some View {
        ForEach(self.fonts, id: \.self) { font in
            self.content(Font(font), font.safeFamilyName)
        }
    }

    public init(
        _ fonts: [UXFont] = UXFont.allFonts,
        @ViewBuilder _ content: @escaping (Font, String) -> Content
    ) {
        self.fonts = fonts
        self.content = content
    }
}

// MARK: - Previews

struct FontIterator_Previews: PreviewProvider {
    private static let pangram = "How vexingly quick daft zebras jump!"

    static var previews: some View {
        FontTester(
            color: .whiteOnBlack,
            textStyle: .body
        ) {
            Text(pangram)
        }
    }
}

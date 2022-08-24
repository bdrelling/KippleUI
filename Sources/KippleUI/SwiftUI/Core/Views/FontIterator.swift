// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

public struct FontIterator<Content>: View where Content: View {
    private let fonts: [UIFont]
    private let content: (UIFont) -> Content

    public var body: some View {
        ForEach(self.fonts, id: \.self) { font in
            self.content(font)
        }
    }

    public init(
        _ fonts: [UIFont] = UIFont.allFonts,
        @ViewBuilder _ content: @escaping (UIFont) -> Content
    ) {
        self.fonts = fonts
        self.content = content
    }
}

// MARK: - Previews

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct FontIterator_Previews: PreviewProvider {
    private static let pangram = "How vexingly quick daft zebras jump!"

    static var previews: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                FontIterator { font in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(font.familyName)
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(self.pangram)
                            .font(font)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .previewMatrix(.sizeThatFits)
    }
}

#endif

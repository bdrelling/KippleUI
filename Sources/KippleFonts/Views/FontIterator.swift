// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct FontIterator<Content>: View where Content: View {
    private let fonts: [UXFont]
    private let content: (Font, String) -> Content

    public var body: some View {
        ForEach(self.fonts, id: \.self) { font in
            self.content(Font(font), font.safeFamilyName)
        }
        .onAppear {
            for font in self.fonts.sorted(by: { $0.safeFamilyName < $1.safeFamilyName }) {
                print("---")
                print("Font: \(font)")
                print("Family Name: \(font.safeFamilyName)")
                print("Descriptor: \(font.fontDescriptor)")
                print("---")
            }
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
//        ScrollView {
//            LazyVStack(alignment: .leading, spacing: 16) {
//                FontIterator { font, familyName in
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(familyName)
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//
//                        Text(self.pangram)
//                            .font(font)
//                    }
//                    .fixedSize(horizontal: false, vertical: true)
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//        }

        FontTester(
            color: .whiteOnBlack,
            textStyle: .body
        ) {
            Text(pangram)
        }
    }
}

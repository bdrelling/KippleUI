// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

extension Font: CaseIterable {
    public static var allCases: [Self] = [
        .largeTitle,
        .title,
        .title2,
        .title3,
        .headline,
        .subheadline,
        .body,
        .callout,
        .caption,
        .caption2,
        .footnote,
    ]
}

extension Font: Identifiable {
    public var id: String {
        self.name
    }
}

public extension Font {
    var name: String {
        switch self {
        case .largeTitle:
            return "LargeTitle"
        case .title:
            return "Title"
        case .title2:
            return "Title2"
        case .title3:
            return "Title3"
        case .headline:
            return "Headline"
        case .subheadline:
            return "Subheadline"
        case .body:
            return "Body"
        case .callout:
            return "Callout"
        case .caption:
            return "Caption"
        case .caption2:
            return "Caption2"
        case .footnote:
            return "Footnote"
        default:
            return "unknown"
        }
    }
}

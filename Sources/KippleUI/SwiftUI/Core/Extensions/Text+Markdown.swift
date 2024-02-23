// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

extension Text {
    init(markdown text: String) {
        do {
            let attributedString = try AttributedString(markdown: text)
            self = .init(attributedString)
        } catch {
            self = .init(text)
        }
    }
}

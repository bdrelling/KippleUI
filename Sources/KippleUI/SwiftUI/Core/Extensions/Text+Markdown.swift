// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@available(macOS 12.0, *)
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

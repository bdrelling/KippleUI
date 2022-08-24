// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

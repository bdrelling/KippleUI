// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Text {
    // TODO: Validate if self.init(LocalizedStringKey(markdown)) works?
    init(markdown text: String) {
        do {
            let attributedString = try AttributedString(markdown: text)
            self = .init(attributedString)
        } catch {
            self = .init(text)
        }
    }
}

// MARK: - Previews

struct Text_Markdown_Previews: PreviewProvider {
    static var previews: some View {
        Text(markdown: "Now _this_ is some **Markdown** text! And [here](https://commonmark.org/)'s the spec")
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension String {
    func copyToClipboard() {
        let pasteboard: UIPasteboard = .general
        pasteboard.string = self
    }
}

#endif

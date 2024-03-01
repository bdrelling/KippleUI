// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension String {
    func copyToClipboard() {
        let pasteboard: UIPasteboard = .general
        pasteboard.string = self
    }
}

#elseif canImport(AppKit)

import AppKit

public extension String {
    func copyToClipboard() {
        let pasteboard: NSPasteboard = .general
        pasteboard.clearContents()
        pasteboard.setString(self, forType: .string)
    }
}

#endif

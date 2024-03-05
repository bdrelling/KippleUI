// Copyright © 2024 Brian Drelling. All rights reserved.

// Internal typealias for ease of reference, but we don't want to expose it and confuse downstream consumers.
#if canImport(UIKit)

import UIKit

typealias UXColor = UIColor

#elseif canImport(AppKit)

import AppKit

typealias UXColor = NSColor

#endif

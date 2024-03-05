// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

/// Internal typealias for ease of reference where `UIColor` and `NSColor` implementations are identical.
public typealias UXColor = UIColor

#elseif canImport(AppKit)

import AppKit

/// Internal typealias for ease of reference where `UIColor` and `NSColor` implementations are identical.
public typealias UXColor = NSColor

#endif

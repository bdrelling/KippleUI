// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

/// Internal typealias for ease of reference where `UIFont` and `NSFont` implementations are identical.
public typealias UXFont = UIFont

#elseif canImport(AppKit)

import AppKit

/// Internal typealias for ease of reference where `UIFont` and `NSFont` implementations are identical.
public typealias UXFont = NSFont

#endif

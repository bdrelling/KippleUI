// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension NSNumber {
    /// Returns wether or not the underlying value is a boolean value.
    /// Used to distinguish the difference between a zero and false value or a one and true value.
    var isBoolean: Bool {
        CFGetTypeID(self as CFTypeRef) == CFBooleanGetTypeID()
    }
}

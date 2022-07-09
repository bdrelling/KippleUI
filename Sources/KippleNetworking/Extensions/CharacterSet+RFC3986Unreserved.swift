// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension CharacterSet {
    /// Characters that are allowed in a URI but do not have a reserved purpose are called unreserved.
    /// These include uppercase and lowercase letters, decimal digits, hyphen, period, underscore, and tilde.
    ///
    /// [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) (see Section 2.3)
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}

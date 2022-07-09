// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into an HTTP header dictionary.
public protocol HTTPHeaderDictionaryConvertible {
    /// Returns a `[String: String]` representation of this object.
    func asHeaderDictionary() -> [String: String]
}

extension Dictionary: HTTPHeaderDictionaryConvertible where Key: HTTPHeaderConvertible, Value == String {
    public func asHeaderDictionary() -> [String: String] {
        var headers: [String: String] = [:]

        for element in self {
            headers[element.key.rawValue] = element.value
        }

        return headers
    }
}

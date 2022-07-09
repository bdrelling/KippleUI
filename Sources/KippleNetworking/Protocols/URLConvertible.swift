// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into a `URL`.
public protocol URLConvertible {
    /// Returns a `URL` representation of this object.
    func asURL() throws -> URL
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        self
    }
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        if let url = URL(string: self) {
            return url
        } else {
            throw NetworkingError.invalidURLString(self)
        }
    }
}

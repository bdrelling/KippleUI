// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into a `URLRequest`.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` representation of this object.
    func asURLRequest() throws -> URLRequest
}

extension URLRequest: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        self
    }
}

extension URL: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        URLRequest(url: self)
    }
}

extension String: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        if let url = URL(string: self) {
            return URLRequest(url: url)
        } else {
            throw NetworkingError.invalidURLString(self)
        }
    }
}

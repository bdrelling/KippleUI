// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into an HTTP header string.
public protocol HTTPHeaderConvertible: Hashable {
    /// Returns a `String` representation of this object.
    var rawValue: String { get }
}

// FIXME: Adding the "rawValue" property to all String objects is bad!
extension String: HTTPHeaderConvertible {
    public var rawValue: String {
        self
    }
}

extension HTTPHeader: HTTPHeaderConvertible {}
//
///// A convenience protocol for converting an object into an HTTP header string.
// public protocol HTTPHeaderConvertible: Hashable {
//    /// Returns a `HTTPHeader` representation of this object.
//    func asHTTPHeader() throws -> HTTPHeader
// }
//
//// MARK: - Extensions
//
// extension HTTPHeader: HTTPHeaderConvertible {
//    public func asHTTPHeader() throws -> HTTPHeader {
//        return self
//    }
// }
//
// extension String: HTTPHeaderConvertible {
//    public func asHTTPHeader() throws -> HTTPHeader {
//        guard let header = HTTPHeader(rawValue: self) else {
//            throw NetworkingError.invalidHTTPHeader(self)
//        }
//
//        return header
//    }
// }

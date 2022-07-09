// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import KippleCodable

public enum NetworkingError: Error {
    case invalidContentType(String)
    case invalidHTTPHeader(String)
    case invalidStatusCode(HTTPStatusCode)
    case invalidURLString(String)
    case invalidURLResponse
    case unableToDecode(String, DecodingError?)
    case unexpectedError
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalidContentType(contentType):
            return "Invalid content type '\(contentType)'."
        case let .invalidHTTPHeader(rawValue):
            return "Invalid HTTP Header '\(rawValue)'."
        case let .invalidStatusCode(statusCode):
            return "Invalid status code '\(statusCode.rawValue)'."
        case let .invalidURLString(urlString):
            return "Invalid URL string '\(urlString)'."
        case .invalidURLResponse:
            return "Invalid URL Response."
        case let .unableToDecode(objectName, .some(underlyingError)):
            return "Unable to decode '\(objectName)'. \(underlyingError.cleanedDescription)"
        case let .unableToDecode(objectName, _):
            return "Unable to decode '\(objectName)'."
        case .unexpectedError:
            return "An unexpected error has occurred."
        }
    }
}

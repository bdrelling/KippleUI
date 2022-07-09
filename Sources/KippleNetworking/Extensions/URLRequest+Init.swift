// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension URLRequest {
    /// Creates a configured URLRequest.
    /// - Parameter url: The URL for the request. Accepts a URL or a String.
    /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
    /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
    /// - Parameter headers: The HTTP headers to send with the request.
    /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
    /// - Returns: The configured `URLRequest` object.
    init(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: ParameterDictionaryConvertible? = nil,
        headers: HTTPHeaderDictionaryConvertible? = nil,
        encoding: ParameterEncoding? = nil
    ) throws {
        let url = try url.asURL()
        self.init(url: url)

        self.httpMethod = method.rawValue

        self.setHeaders(headers)

        // Parameters must be set after setting headers, because encoding dictates (and therefore overrides) the Content-Type header
        self.setParameters(parameters, method: method, encoding: encoding)
    }
}

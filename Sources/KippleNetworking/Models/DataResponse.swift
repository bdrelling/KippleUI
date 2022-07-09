// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// The response that is returned by the server from an HTTP request.
public struct DataResponse<Success, Failure: Error> {
    /// The request sent to the server.
    public let request: URLRequest?

    /// The response returned by the server.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The serialized result of the request sent to the server.
    public let result: Result<Success, Failure>

    /// The success value of the serialized result.
    public var value: Success? {
        self.result.success
    }

    /// The error value of the serialized result.
    public var error: Failure? {
        self.result.failure
    }

    /// Creates an `HTTPResult` object composed of the result of an HTTP request.
    ///
    /// - Parameters:
    ///   - request:    The request sent to the server.
    ///   - response:   The response returned by the server.
    ///   - data:       The data returned by the server.
    ///   - result:     The serialized result of the request sent to the server.
    public init(request: URLRequest?,
                response: HTTPURLResponse?,
                data: Data?,
                result: Result<Success, Failure>) {
        self.request = request
        self.response = response
        self.data = data
        self.result = result
    }
}

public extension DataResponse {
    /// The status code returned by the request.
    var status: HTTPStatusCode? {
        self.response?.status
    }

    /// The raw status code returned by the request.
    var statusCode: Int? {
        self.response?.statusCode
    }
}

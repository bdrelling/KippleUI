// Copyright © 2022 Brian Drelling. All rights reserved.

extension DataResponse {
    /// Initializes a `DataResponse` object with `nil` request, response, and data properties
    /// and a failure result containing the given error.
    /// - Parameter error: The error to return in the result of the response.
    static func failure<T>(_ error: Error) -> DataResponse<T, Error> {
        DataResponse<T, Error>(request: nil,
                               response: nil,
                               data: nil,
                               result: .failure(error))
    }
}

// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension HTTPURLResponse {
    /// The enum-based HTTP status code.
    var status: HTTPStatusCode {
        // It is unlikely that HTTPURLResponse will ever get an undefined status code by a service in production
        // If it does, we should return the undefined (-1) status code
        guard let status = HTTPStatusCode(rawValue: self.statusCode) else {
            return .undefined
        }

        return status
    }
}

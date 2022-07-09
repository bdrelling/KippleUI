// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.flatMap { self.evaluatedQueryItems(for: $0) }

        // This will encode the query parameters following RFC 3986
        self.percentEncodedQuery = self.queryItems?.compactMap {
            guard
                let escapedName = $0.name.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved),
                let escapedValue = $0.value?.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved) else {
                return nil
            }

            return "\(escapedName)=\(escapedValue)"
        }
        .joined(separator: "&")
    }

    private func evaluatedQueryItems(for parameter: (key: String, value: Any)) -> [URLQueryItem] {
        switch parameter.value {
        case let dictionary as [String: Any]:
            return dictionary.flatMap {
                // Recursively get the URLQueryItem for each dictionary item's value
                // For each level of the dictionary, add the key onto the end per typical dictionary syntax
                // Example: dictionary[first][second][third] (no quotes!)
                self.evaluatedQueryItems(for: (key: "\(parameter.key)[\($0)]", value: $1))
            }
        case let array as [Any]:
            // TODO: Allow encoding of arrays without brackets (and as comma-delimited list?)
            return array.flatMap {
                // Recursively get the URLQueryItem for each array item's value
                // For each level of the array (eg. multi-dimensional arrays), add brackets to the end per typical array syntax
                // Example: array[][][] (no indexes!)
                self.evaluatedQueryItems(for: (key: "\(parameter.key)[]", value: $0))
            }
        case let value:
            // If the value is a boolean, display it as "true"/"false"
            if let nsNumber = value as? NSNumber, nsNumber.isBoolean {
                return [URLQueryItem(name: parameter.key, value: String(describing: nsNumber.boolValue))]
            } else {
                return [URLQueryItem(name: parameter.key, value: String(describing: value))]
            }
        }
    }
}

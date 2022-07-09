// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension URLRequest {
    // TODO: Drop the requirement of this function. The problem is that we need one function for if the method is set,
    //       and another if the method is unset. We can refactor this, just need to determine the right way.
    //
    //       Examples:
    //       1, method without encoding: Use the default method's encoding.
    //       2. method with encoding: Use the method, but override the encoding.
    //       3. encoding without method: Doesn't matter what method, override the encoding.
    mutating func setParameters(_ parameters: ParameterDictionaryConvertible?, method: HTTPMethod, encoding: ParameterEncoding? = nil) {
        let encoding = encoding ?? .defaultEncoding(for: method)
        self.setParameters(parameters, encoding: encoding)
    }

    mutating func setParameters(_ parameters: ParameterDictionaryConvertible?, encoding: ParameterEncoding) {
        guard let url = self.url, let parameters = parameters?.asParameterDictionary() else {
            return
        }

        switch encoding {
        case .httpBody(.json):
            self.setValue(HTTPBodyEncoding.json.rawValue, forHTTPHeaderField: .contentType)

            do {
                self.httpBody = try parameters.asJSONSerializedData()
            } catch {
                // TODO: Throw error
            }
        case .httpBody(.wwwFormURLEncoded):
            self.setValue(HTTPBodyEncoding.wwwFormURLEncoded.rawValue, forHTTPHeaderField: .contentType)

            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.setQueryItems(with: parameters)

            self.httpBody = urlComponents?.percentEncodedQuery?.data(using: .utf8)
        case .queryString:
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.setQueryItems(with: parameters)

            self.url = urlComponents?.url
        }
    }

    mutating func setParameters(_ encodable: Encodable, method: HTTPMethod, encoding: ParameterEncoding? = nil) {
        let parameters = try? encodable.asDictionary()
        self.setParameters(parameters, method: method, encoding: encoding)
    }

    mutating func setParameters(_ encodable: Encodable, encoding: ParameterEncoding) {
        let parameters = try? encodable.asDictionary()
        self.setParameters(parameters, encoding: encoding)
    }
}

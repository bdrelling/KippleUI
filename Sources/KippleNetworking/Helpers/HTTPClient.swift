// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public final class HTTPClient {
    private let session: URLSession
    private let jsonDecoder = JSONDecoder()

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<Response: Decodable>(_ urlRequest: URLRequest) async throws -> Response {
        let (data, _) = try await self.session.data(for: urlRequest)
        return try self.jsonDecoder.decode(Response.self, from: data)
    }

    public func request<Response: Decodable>(_ url: URL) async throws -> Response {
        try await self.request(.init(url: url))
    }
}

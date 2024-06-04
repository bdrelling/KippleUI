// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

// Source: https://danielsaidi.com/blog/2023/08/23/storagecodable
public protocol StorageCodable: Codable, RawRepresentable {}

// MARK: - Extensions

public extension StorageCodable {
    init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Self.self, from: data)
        else { return nil }
        self = result
    }

    var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else { return "" }
        return result
    }
}

// MARK: - Default Conformances

extension Date: StorageCodable {}

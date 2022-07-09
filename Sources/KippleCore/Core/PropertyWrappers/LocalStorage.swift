// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

@propertyWrapper
public struct LocalStorage<Value: Codable> {
    private let key: String
    private let defaultValue: Value

    private let userDefaults: UserDefaults = .standard

    public init(_ key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        get {
            // Read value from UserDefaults.
            guard let data = self.userDefaults.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults.
                return self.defaultValue
            }

            // Convert data to the desire data type.
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? self.defaultValue
        }
        set {
            // Convert newValue to data.
            let data = try? JSONEncoder().encode(newValue)

            // Set value to UserDefaults.
            self.userDefaults.set(data, forKey: self.key)
        }
    }
}

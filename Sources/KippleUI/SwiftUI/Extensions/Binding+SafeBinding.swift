// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension Binding {
    /// Converts this `Binding` to a non-optional one using a default value.
    /// - Returns: A non-optional `Binding`.
    func safeBinding<T>(defaultValue: T) -> Binding<T> where Value == T? {
        .init {
            self.wrappedValue ?? defaultValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }

    /// Converts this `Binding` to a non-optional one, or returns `nil`.
    /// - Returns: A non-optional `Binding`, or `nil`.
    func trySafeBinding<T>() -> Binding<T>? where Value == T? {
        guard let wrappedValue = self.wrappedValue else {
            return nil
        }

        return Binding<T>.init {
            wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
}

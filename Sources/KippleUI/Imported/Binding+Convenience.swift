// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension Binding where Value == Bool {
    /// Inverts a `Bool` binding, such that its fetched and provided value are flipped.
    ///
    /// This is helpful when a parent`View` has a binding like `isEnabled`,
    /// but you need to initialize a child `View` with a binding like `isDisabled`.
    ///
    /// Since `!$isEnabled` is not possible, we can use `$isEnabled.not()` to make the binding
    /// behave like `$isDisabled` would, all while keeping the relationship to the original `$isEnabled` intact.
    func not() -> Binding<Bool> {
        .init(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}

public extension Binding where Value == String {
    /// Limits the `String` `Value` to a maximum number of characters.
    ///
    /// Source: https://www.hackingwithswift.com/forums/swiftui/limit-characters-in-a-textfield/15017/15018
    func max(_ limit: Int) -> Self {
        if wrappedValue.count > limit {
            Task {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}

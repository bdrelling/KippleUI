// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

private struct IsDebuggingKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isDebugging: Bool {
        get { self[IsDebuggingKey.self] }
        set { self[IsDebuggingKey.self] = newValue }
    }
}

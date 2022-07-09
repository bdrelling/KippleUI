// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

extension ColorScheme {
    var abbreviation: String {
        switch self {
        case .dark:
            return "D"
        case .light:
            return "L"
        @unknown default:
            return "Unknown"
        }
    }

    var name: String {
        switch self {
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        @unknown default:
            return "Unknown"
        }
    }
}

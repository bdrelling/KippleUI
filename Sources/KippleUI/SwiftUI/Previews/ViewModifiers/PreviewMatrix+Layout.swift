// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension PreviewMatrix {
    enum Layout {
        case currentDevice
        case device(PreviewDevice)
        case fixedSize(width: CGFloat, height: CGFloat)
        case sizeThatFits
    }
}

// MARK: - Extensions

extension PreviewMatrix.Layout {
    var name: String {
        switch self {
        case .currentDevice:
            return "Current Device"
        case let .device(previewDevice):
            return previewDevice.rawValue
        case .sizeThatFits:
            return "Size That Fits"
        case let .fixedSize(width, height):
            // Shortcut format for removing trailing zeroes
            return String(format: "%g x %g", width, height)
        }
    }

    var previewDevice: PreviewDevice? {
        switch self {
        case let .device(previewDevice):
            return previewDevice
        default:
            return nil
        }
    }

    var previewLayout: PreviewLayout {
        switch self {
        case .currentDevice,
             .device:
            return .device
        case let .fixedSize(width, height):
            return .fixed(width: width, height: height)
        case .sizeThatFits:
            return .sizeThatFits
        }
    }
}

extension PreviewMatrix.Layout: Identifiable {
    // swiftlint:disable:next identifier_name
    public var id: String {
        switch self {
        case .currentDevice:
            return "currentDevice"
        case let .device(previewDevice):
            return "device[\(previewDevice)]"
        case .sizeThatFits:
            return "sizeThatFits"
        case let .fixedSize(width, height):
            return "fixedSize[\(width)x\(height)]"
        }
    }
}

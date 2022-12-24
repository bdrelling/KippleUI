// Copyright © 2022 Brian Drelling. All rights reserved.

import CoreGraphics

public extension PreviewMatrix {
    static let `default` = PreviewMatrix(layouts: .default)
    static let currentDevice = PreviewMatrix(layouts: .currentDevice)
    static let sizeThatFits = PreviewMatrix(layouts: .sizeThatFits)

    static let modernPhones = PreviewMatrix(layouts: .modernPhones)
    static let modernTablets = PreviewMatrix(layouts: .modernTablets)
    static let modernDevices = PreviewMatrix(layouts: .modernDevices)
    static let currentAndModernDevices = PreviewMatrix(layouts: .currentAndModernDevices)

    static func fixedSize(width: CGFloat, height: CGFloat) -> Self {
        .init(layouts: .fixedSize(width: width, height: height))
    }
}

public extension Array where Element == PreviewMatrix.Layout {
    static let `default`: Self = .currentDevice

    static let currentDevice: Self = [.currentDevice]

    static let modernPhones: Self = .devices(
        .iPhone14,
        .iPhone14Pro
    )

    static let modernTablets: Self = .devices(
        .iPadPro11InchGen4
    )

    static let modernDevices: Self = .modernPhones + .modernTablets

    static let currentAndModernDevices: Self = {
        let alreadyContainsCurrentDevice = Self.modernPhones.contains {
            $0.id == PreviewMatrix.Layout.currentDevice.id
        }

        if alreadyContainsCurrentDevice {
            return .modernPhones
        } else {
            return .currentDevice + .modernPhones
        }
    }()

    static func device(_ deviceType: PreviewDeviceType) -> Self {
        [.device(deviceType)]
    }

    static func devices(_ deviceTypes: PreviewDeviceType...) -> Self {
        deviceTypes.map { .device($0) }
    }

    static let sizeThatFits: Self = [.sizeThatFits]

    static func fixedSize(width: CGFloat, height: CGFloat) -> Self {
        [.fixedSize(width: width, height: height)]
    }
}

public extension PreviewMatrix.Layout {
    static func device(_ deviceType: PreviewDeviceType) -> Self {
        .device(.init(deviceType))
    }
}

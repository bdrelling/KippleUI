// Copyright © 2022 Brian Drelling. All rights reserved.

public extension PreviewMatrix {
    static let `default` = PreviewMatrix(layouts: .default)
    static let currentDevice = PreviewMatrix(layouts: .currentDevice)
    static let modernTablets = PreviewMatrix(layouts: .modernTablets)
    static let modernPhones = PreviewMatrix(layouts: .modernPhones)
    static let modernDevices = PreviewMatrix(layouts: .modernDevices)
    static let sizeThatFits = PreviewMatrix(layouts: .sizeThatFits)
}

public extension Array where Element == PreviewMatrix.Layout {
    static let `default` = .currentDevice + .modernPhones

    static let currentDevice: Self = [.currentDevice]

    static let modernTablets: Self = .device(.iPadPro11InchGen3)

    static let modernPhones: Self = .devices(
        .iPhone13,
        .iPhoneSEGen2
    )

    static let modernDevices: Self = .modernPhones + .modernTablets

    static func device(_ deviceType: PreviewDeviceType) -> Self {
        [.device(deviceType)]
    }

    static func devices(_ deviceTypes: PreviewDeviceType...) -> Self {
        deviceTypes.map { .device($0) }
    }

    static let sizeThatFits: Self = [.sizeThatFits]
}

public extension PreviewMatrix.Layout {
    static func device(_ deviceType: PreviewDeviceType) -> Self {
        .device(.init(deviceType))
    }
}

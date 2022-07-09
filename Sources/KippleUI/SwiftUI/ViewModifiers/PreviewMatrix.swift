// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct PreviewMatrix: ViewModifier {
    public let layouts: [Layout]
    public let colorSchemes: [ColorScheme]

    public init(layouts: [Layout], colorSchemes: [ColorScheme] = ColorScheme.allCases) {
        self.layouts = layouts
        self.colorSchemes = colorSchemes
    }

    public func body(content: Content) -> some View {
        ForEach(self.layouts, id: \.id) { layout in
            ForEach(self.colorSchemes, id: \.self) { colorScheme in
                content
                    // Set up the preview configuration
                    .previewLayout(layout.previewLayout)
                    .previewDevice(layout.previewDevice)
                    .previewDisplayName("\(layout.name) (\(colorScheme.name))")
                    // Apply color schemes to the modified preview
                    .preferredColorScheme(colorScheme)
            }
        }
    }
}

// MARK: - Supporting Types

public extension PreviewMatrix {
    enum Layout {
        case currentDevice
        case device(PreviewDevice)
        case fixedSize(width: CGFloat, height: CGFloat)
        case sizeThatFits
    }
}

// MARK: - Private Extensions

private extension PreviewMatrix.Layout {
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

private extension ColorScheme {
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

// MARK: - Convenience Extensions

public extension PreviewMatrix {
    private static let modernTabletsList: [Layout] = [
        .iPadPro11Inch,
    ]

    private static let modernPhonesList: [Layout] = [
        .iPhone13,
        .iPhoneSE,
    ]

    static let `default` = PreviewMatrix(layouts: [.currentDevice])
    static let modernTablets = PreviewMatrix(layouts: Self.modernTabletsList)
    static let modernPhones = PreviewMatrix(layouts: Self.modernPhonesList)
    static let modernDevices = PreviewMatrix(layouts: Self.modernPhonesList + Self.modernTabletsList)

    /// The standard array of devices for Goblintown.
    static let standard = PreviewMatrix(layouts: [
        .iPhone13Pro,
        .iPhoneSE,
        .sizeThatFits,
    ])
}

public extension PreviewMatrix.Layout {
    static let iPhoneSE: PreviewMatrix.Layout = .device("iPhone SE (2nd generation)")
    static let iPhone13: PreviewMatrix.Layout = .device("iPhone 13")
    static let iPhone13Mini: PreviewMatrix.Layout = .device("iPhone 13 mini")
    static let iPhone13Pro: PreviewMatrix.Layout = .device("iPhone 13 Pro")
    static let iPhone13ProMax: PreviewMatrix.Layout = .device("iPhone 13 Pro Max")
    static let iPadPro11Inch: PreviewMatrix.Layout = .device("iPad Pro (11-inch) (3rd generation)")
}

// MARK: - ViewModifier Extensions

public extension View {
    func previewMatrix(_ matrix: PreviewMatrix) -> some View {
        self.modifier(matrix)
    }

    func previewMatrix(_ layouts: PreviewMatrix.Layout...) -> some View {
        self.modifier(PreviewMatrix(layouts: layouts))
    }

    func previewMatrix(layouts: [PreviewMatrix.Layout] = [.currentDevice]) -> some View {
        self.modifier(PreviewMatrix(layouts: layouts))
    }
}

// MARK: - Previews

struct PreviewMatrix_Previews: PreviewProvider {
    static var previews: some View {
        Text("Testing!")
            .previewMatrix(.currentDevice,
                           .iPhone13Pro,
                           .fixedSize(width: 200, height: 80),
                           .sizeThatFits)
    }
}

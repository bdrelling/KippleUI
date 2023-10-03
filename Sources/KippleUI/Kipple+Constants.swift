// Copyright © 2023 Brian Drelling. All rights reserved.

import CoreGraphics
import Foundation
import KippleCore
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

public extension Kipple {
    /// The default animation speed.
    static let defaultAnimationSpeed = 0.35

    /// The default SwiftUI padding value.
    static let defaultPadding: CGFloat = 16

    /// A convenience alias for the default SwiftUI padding value.
    static let defaultPaddingFull = Self.defaultPadding

    /// A convenience alias for one half of the default SwiftUI padding value.
    static let defaultPaddingHalf = Self.defaultPadding / 2

    /// A convenience alias for one quarter of the default SwiftUI padding value.
    static let defaultPaddingQuarter = Self.defaultPadding / 4

    // TODO: Update to include
    /// The current device type.
    static var deviceType: DeviceType {
        #if os(macOS)
        return .mac
        #elseif os(tvOS)
        return .tv
        #elseif os(watchOS)
        return .watch
        #elseif canImport(UIKit)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return .tablet
        case .phone:
            return .phone
        default:
            return .unknown
        }
        #endif
    }

    #if canImport(UIKit)
    static var orientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }
    #endif
}

public enum DeviceType {
    case unknown
    case phone
    case tablet
    case tv
    case mac
    case watch
}

extension Kipple {
    /// Whether or not the app is running unit or UI tests.
    @available(*, deprecated, message: "Use Bool+Convenience extensions instead.") static var isRunningTests: Bool = .isRunningTests

    /// Whether or not the app is running unit tests.
    @available(*, deprecated, message: "Use Bool+Convenience extensions instead.") static var isRunningUnitTests: Bool = .isRunningUnitTests

    /// Whether or not the app is running UI tests.
    @available(*, deprecated, message: "Use Bool+Convenience extensions instead.") static var isRunningUITests: Bool = .isRunningUITests

    /// Whether or not the app is in a debugging state.
    @available(*, deprecated, message: "Use Bool+Convenience extensions instead.") static var isDebugging: Bool = .isDebugging

    /// Whether or not the application should mock external services, from networking to hardware operations.
    /// This is used primarily for testing and Xcode Previews in order to improve performance.
    @available(*, deprecated, message: "Use Bool+Convenience extensions instead.") static var shouldMockExternalServices: Bool = .shouldMockExternalServices
}

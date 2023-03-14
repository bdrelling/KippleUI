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

    /// Whether or not the app is running unit or UI tests.
    static var isRunningTests: Bool {
        self.isRunningUnitTests || self.isRunningUITests
    }

    /// Whether or not the app is running unit tests.
    static var isRunningUnitTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }

    /// Whether or not the app is running UI tests.
    static var isRunningUITests: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui_testing")
    }

    /// Whether or not the application should mock external services, from networking to hardware operations.
    /// This is used primarily for testing and Xcode Previews in order to improve performance.
    static var shouldMockExternalServices: Bool {
        Kipple.isRunningTests || Kipple.isRunningInXcodePreview
    }

    /// Whether or not the app is in a debugging state.
    static var isDebugging: Bool {
        #if DEBUG
        true
        #else
        false
        #endif
    }

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

// Copyright © 2024 Brian Drelling. All rights reserved.

//// Copyright © 2024 Brian Drelling. All rights reserved.
//
// import CoreGraphics
// import Foundation
// import KippleFoundation
// import SwiftUI
//
// #if canImport(UIKit)
// import UIKit
// #endif
//
// public extension Kipple {
//    // TODO: Update to include
//    /// The current device type.
//    static var deviceType: DeviceType {
//        #if os(macOS)
//        return .mac
//        #elseif os(tvOS)
//        return .tv
//        #elseif os(watchOS)
//        return .watch
//        #elseif canImport(UIKit)
//        switch UIDevice.current.userInterfaceIdiom {
//        case .pad:
//            return .tablet
//        case .phone:
//            return .phone
//        default:
//            return .unknown
//        }
//        #endif
//    }
//
//    #if canImport(UIKit)
//    static var orientation: UIDeviceOrientation {
//        UIDevice.current.orientation
//    }
//    #endif
// }
//
// public enum DeviceType {
//    case unknown
//    case phone
//    case tablet
//    case tv
//    case mac
//    case watch
// }

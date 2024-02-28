// Copyright © 2024 Brian Drelling. All rights reserved.

//// Copyright © 2024 Brian Drelling. All rights reserved.
//
// import Foundation
// import KippleCore
//
// protocol DeviceHelping {
//    static var deviceFamily: DeviceFamily { get }
//    static var deviceInfo: DeviceInfo { get }
//    static var deviceModel: String { get }
//    static var systemName: String { get }
//    static var systemVersionString: String { get }
//    static var systemVersion: SemanticVersion { get }
// }
//
// #if canImport(UIKit) && canImport(DeviceKit)
//
// import DeviceKit
// import UIDeviceComplete
// import UIKit
//
// public final class DeviceHelper: DeviceHelping {
//    private static var device: Device {
//        .current
//    }
//
//    public static var deviceFamily: DeviceFamily {
//        UIDevice.current.dc.deviceFamily
//        // TODO: This won't work for macOS, tvOS, etc. etc.
////        device.dc.deviceFamily.rawValue
//
//
//
//        #if os(watchOS)
//        return "watchOS"
//        #elseif os(macOS)
//        return "macOS"
//        #else
//        fatalError("UNKNOWN")
//        #endif
//    }
//
//    public static var deviceIdiom: UIUserInterfaceIdiom {
//        UIDevice.current.userInterfaceIdiom
//    }
//
//    public static var deviceInfo: DeviceInfo {
//        .init(
//            appVersion: Bundle.main.bundleVersion,
//            appBuildNumber: Bundle.main.bundleBuildNumber,
//            deviceFamily: deviceFamily,
//            deviceModel: deviceModel,
//            systemName: systemName,
//            systemVersion: systemVersion
//        )
//    }
//
//    public static var deviceIdiomName: String {
//        deviceIdiom.name
//    }
//
//    public static var deviceModel: String {
//        device.dc.commonDeviceName
//    }
//
//    public static var systemName: String {
//        device.systemName
//    }
//
//    public static var systemVersionString: String {
//        device.systemVersion
//    }
//
//    public static var systemVersion: SemanticVersion {
//        .from(systemVersionString)
//    }
//
//    private init() {}
// }
//
//// MARK: - Extensions
//
// private extension UIUserInterfaceIdiom {
//    var name: String {
//        switch self {
//        case .unspecified:
//            return "Unspecified"
//        case .phone:
//            return "Phone"
//        case .pad:
//            return "Pad"
//        case .tv:
//            return "TV"
//        case .carPlay:
//            return "CarPlay"
//        case .mac:
//            return "Mac"
//        @unknown default:
//            return "Unknown"
//        }
//    }
// }
//
// #else
//
// public final class DeviceHelper: DeviceHelping {
////    private static var device: UIDevice {
////        UIDevice.current
////    }
//
//    public static var deviceFamily: String {
//        ""
//    }
//
//    public static var deviceInfo: DeviceInfo {
//        .init(
//            appVersion: Bundle.main.bundleVersion,
//            appBuildNumber: Bundle.main.bundleBuildNumber,
//            deviceFamily: deviceFamily,
//            deviceModel: deviceModel,
//            systemName: systemName,
//            systemVersion: systemVersion
//        )
//    }
//
//    public static var deviceModel: String {
//        ""
//    }
//
//    public static var systemName: String {
//        ""
//    }
//
//    public static var systemVersionString: String {
//        ""
//    }
//
//    public static var systemVersion: SemanticVersion {
//        .from("0.1.0")
//    }
//
//    private init() {}
// }
//
// #endif
//
//
// public enum DeviceFamily: String, Equatable, Hashable, Codable {
//    case iPhone
//    case iPod
//    case iPad
//    case mac = "Mac"
//    case appleWatch = "Apple Watch"
//    case appleTV = "Apple TV"
//    case unknown = "Unknown"
// }

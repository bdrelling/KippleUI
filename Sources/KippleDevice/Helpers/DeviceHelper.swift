// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleCore

protocol DeviceHelping {
    static var deviceFamily: String { get }
    static var deviceInfo: DeviceInfo { get }
    static var deviceModel: String { get }
    static var systemName: String { get }
    static var systemVersionString: String { get }
    static var systemVersion: SemanticVersion { get }
}

#if canImport(UIKit) && canImport(UIDeviceComplete)

    import UIDeviceComplete
    import UIKit

    public final class DeviceHelper: DeviceHelping {
        private static var device: UIDevice {
            UIDevice.current
        }

        public static var deviceFamily: String {
            // TODO: This won't work for macOS, tvOS, etc. etc.
            self.device.dc.deviceFamily.rawValue
        }

        public static var deviceIdiom: UIUserInterfaceIdiom {
            self.device.userInterfaceIdiom
        }

        public static var deviceInfo: DeviceInfo {
            .init(
                appVersion: BundleHelper.appVersion,
                appBuildNumber: BundleHelper.appBuildNumber,
                deviceFamily: self.deviceFamily,
                deviceModel: self.deviceModel,
                systemName: self.systemName,
                systemVersion: self.systemVersion
            )
        }

        public static var deviceIdiomName: String {
            self.deviceIdiom.name
        }

        public static var deviceModel: String {
            self.device.dc.commonDeviceName
        }

        public static var systemName: String {
            self.device.systemName
        }

        public static var systemVersionString: String {
            self.device.systemVersion
        }

        public static var systemVersion: SemanticVersion {
            .from(self.systemVersionString)
        }

        private init() {}
    }

    // MARK: - Extensions

    private extension UIUserInterfaceIdiom {
        var name: String {
            switch self {
            case .unspecified:
                return "Unspecified"
            case .phone:
                return "Phone"
            case .pad:
                return "Pad"
            case .tv:
                return "TV"
            case .carPlay:
                return "CarPlay"
            case .mac:
                return "Mac"
            @unknown default:
                return "Unknown"
            }
        }
    }

#else

    public final class DeviceHelper: DeviceHelping {
//    private static var device: UIDevice {
//        UIDevice.current
//    }

        public static var deviceFamily: String {
            ""
        }

        public static var deviceInfo: DeviceInfo {
            .init(
                appVersion: BundleHelper.appVersion,
                appBuildNumber: BundleHelper.appBuildNumber,
                deviceFamily: self.deviceFamily,
                deviceModel: self.deviceModel,
                systemName: self.systemName,
                systemVersion: self.systemVersion
            )
        }

        public static var deviceModel: String {
            ""
        }

        public static var systemName: String {
            ""
        }

        public static var systemVersionString: String {
            ""
        }

        public static var systemVersion: SemanticVersion {
            .from("0.1.0")
        }

        private init() {}
    }

#endif

// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public enum BundleHelper {
    // MARK: Constants

    private static let errorVersionString = "vERR"
    private static let errorBuildNumber = 0

    // MARK: Enums

    public enum Key: String {
        // Apple
        case buildNumber = "CFBundleVersion"
        case version = "CFBundleShortVersionString"
        // Custom
        case sentryDSN = "SentryPublicDSN"
    }

    // MARK: Properties

    public static var appBuildNumber: Int = {
        guard let buildNumberString = Self.string(for: .buildNumber) else {
            return Self.errorBuildNumber
        }

        return Int(buildNumberString) ?? Self.errorBuildNumber
    }()

    public static var appVersion: SemanticVersion = {
        guard let version = Self.string(for: .version) else {
            return .zero
        }

        return .from(version)
    }()

    public static var fullVersion: String = {
        guard let version = Self.string(for: .version) else {
            return Self.errorVersionString
        }

        if Self.isLocal {
            return "v\(version)L" // indicates a local build
        } else {
            return "v\(version)b\(Self.appBuildNumber)" // indicates a hosted build
        }
    }()

    public static var isLocal: Bool {
        Self.appBuildNumber == 0
    }

    // MARK: Methods

    public static func value<T>(for key: String, in bundle: Bundle = .main) -> T? {
        bundle.infoDictionary?[key] as? T
    }

    public static func value<T>(for key: Key, in bundle: Bundle = .main) -> T? {
        self.value(for: key.rawValue, in: bundle)
    }

    public static func string(for key: String, in bundle: Bundle = .main) -> String? {
        bundle.infoDictionary?[key] as? String
    }

    public static func string(for key: Key, in bundle: Bundle = .main) -> String? {
        self.string(for: key.rawValue, in: bundle)
    }
}

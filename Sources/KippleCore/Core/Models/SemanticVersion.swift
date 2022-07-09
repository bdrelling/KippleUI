// Copyright © 2022 Brian Drelling. All rights reserved.

public struct SemanticVersion: Codable {
    // MARK: Properties]

    public let major: Int
    public let minor: Int
    public let patch: Int

    public init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

// MARK: - Extensions

extension SemanticVersion: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        let versionParts = stringLiteral.split(separator: ".")

        switch versionParts.count {
        case 3:
            guard let major = Int(versionParts[0]),
                  let minor = Int(versionParts[1]),
                  let patch = Int(versionParts[2]) else {
                self = .zero
                return
            }

            self.major = major
            self.minor = minor
            self.patch = patch
        case 2:
            guard let major = Int(versionParts[0]),
                  let minor = Int(versionParts[1]) else {
                self = .zero
                return
            }

            self.major = major
            self.minor = minor
            self.patch = 0
        default:
            self = .zero
        }
    }
}

public extension SemanticVersion {
    static let zero: Self = .init(major: 0, minor: 0, patch: 0)

    static func from(_ versionString: String) -> Self {
        .init(stringLiteral: versionString)
    }
}

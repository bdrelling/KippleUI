// swift-tools-version: 5.9

import PackageDescription

// MARK: - Convenience

let allModules: [String] = [
    .kippleColors,
    .kippleFonts,
    .kippleHaptics,
    .kippleShaders,
    .kippleShapes,
]

let allModulesAsProducts = allModules.map { Product.library(name: $0, targets: [$0]) }
let allModulesAsDependencies = allModules.map(Target.Dependency.init)

// MARK: - Package Definition

let package = Package(
    name: "KippleUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [.library(name: .kippleUI, targets: [.kippleUI])] + allModulesAsProducts,
    dependencies: [
        .package(url: "https://github.com/bdrelling/Kipple", revision: "7b64f96fa67d68b35722029f2ef02a417a911b62"), // .upToNextMinor(from: "0.14.2")),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.3")),
    ],
    targets: [
        // Product Targets (without Dependencies)
        .kippleTarget(name: .kippleColors),
        .kippleTarget(name: .kippleFonts),
        .kippleTarget(name: .kippleHaptics),
        // Product Targets (with Dependencies)
        .kippleTarget(
            name: .kippleUI,
            dependencies: [
                .product(name: "KippleFoundation", package: "Kipple"),
            ] + allModulesAsDependencies
        ),
        .kippleTarget(
            name: .kippleShaders,
            resources: [
                .process("Shaders"),
            ]
        ),
        .kippleTarget(
            name: .kippleShapes,
            dependencies: [
                .target(name: .kippleColors),
            ]
        ),
        // Test Targets
        .kippleTestTarget(name: .kippleColors),
        .kippleTestTarget(
            name: .kippleFonts, 
            resources: [
                .process("Resources"),
            ]
        ),
        .kippleTestTarget(name: .kippleShaders),
    ]
)

// MARK: - Extensions

extension Target {
    static func kippleTarget(name: String, dependencies: [Target.Dependency] = [], resources: [Resource]? = nil) -> Target {
        .target(
            name: name,
            dependencies: dependencies,
            resources: resources,
            cSettings: [
                .define("PLATFORM_WATCH_OS", .when(platforms: [.watchOS])),
            ],
            swiftSettings: [
                .define("PLATFORM_WATCH_OS", .when(platforms: [.watchOS])),
            ]
        )
    }
    
    static func kippleTestTarget(name: String, resources: [Resource]? = nil) -> Target {
        .testTarget(
            name: "\(name)Tests",
            dependencies: [
                .target(name: name),
            ],
            resources: resources
        )
    }
}

// MARK: - Constants

/// Defined `String` constants representing each of our modules
extension String {
    static let kippleUI = "KippleUI"
    
    static let kippleColors = "KippleColors"
    static let kippleFonts = "KippleFonts"
    static let kippleHaptics = "KippleHaptics"
    static let kippleShaders = "KippleShaders"
    static let kippleShapes = "KippleShapes"
}

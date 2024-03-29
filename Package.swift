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
        .package(url: "https://github.com/bdrelling/Kipple", .upToNextMinor(from: "0.14.0")),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets (without Dependencies)
        .target(name: .kippleColors),
        .target(name: .kippleFonts),
        .target(name: .kippleHaptics),
        // Product Targets (with Dependencies)
        .target(
            name: .kippleUI,
            dependencies: [
                .product(name: "KippleFoundation", package: "Kipple"),
            ] + allModulesAsDependencies
        ),
        .target(
            name: .kippleShaders,
            resources: [
                .process("Shaders"),
            ]
        ),
        .target(
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

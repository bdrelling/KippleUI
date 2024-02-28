// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "KippleUI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "KippleFont", targets: ["KippleFont"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-kipple/Core", revision: "5a55473a7718c4cca046be508b30e3ead16aa4d7"),// .upToNextMinor(from: "0.12.0")),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleFont",
            dependencies: []
        ),
        .target(
            name: "KippleUI",
            dependencies: [
                .product(name: "KippleCore", package: "Core"),
                .target(name: "KippleFont"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "KippleFontTests",
            dependencies: [
                .target(name: "KippleFont"),
            ]
        )
    ]
)

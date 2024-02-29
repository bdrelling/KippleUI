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
        .package(url: "https://github.com/bdrelling/Kipple", revision: "7adb2ccc7b330e015cce810fc8d8e76670aa5404"),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.0")),
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
                .product(name: "KippleFoundation", package: "Kipple"),
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

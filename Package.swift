// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "KippleUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
        .library(name: "KippleFont", targets: ["KippleFont"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Nirma/UIDeviceComplete", from: "3.0.0"),
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.12.1")),
        .package(url: "https://github.com/swift-kipple/Tools", from: "0.3.0"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleDevice",
            dependencies: [
                .product(name: "KippleCore", package: "Core"),
                .product(name: "UIDeviceComplete", package: "UIDeviceComplete", condition: .when(platforms: [.iOS])),
            ]
        ),
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

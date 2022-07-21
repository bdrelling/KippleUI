// swift-tools-version:5.6

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
        .library(name: "KippleUI", targets: ["KippleUI", "SafeNavigationKit"]),
        .library(name: "SafeNavigationKit", targets: ["SafeNavigationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.9.2")),
        .package(url: "https://github.com/Nirma/UIDeviceComplete", .upToNextMajor(from: "2.8.1")),
        // Development
        .package(url: "https://github.com/swift-kipple/Plugins", from: "0.3.1"),
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
            name: "KippleUI",
            dependencies: [
                .product(name: "KippleCore", package: "Core"),
            ]
        ),
        .target(
            name: "SafeNavigationKit",
            dependencies: []
        ),
    ]
)

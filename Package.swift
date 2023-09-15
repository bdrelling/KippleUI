// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "KippleUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Nirma/UIDeviceComplete", from: "2.8.1"),
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.11.2")),
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
            name: "KippleUI",
            dependencies: [
                .product(name: "KippleCore", package: "Core"),
            ]
        ),
    ]
)

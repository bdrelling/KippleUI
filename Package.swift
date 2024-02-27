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
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
        .library(name: "KippleFont", targets: ["KippleFont"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Nirma/UIDeviceComplete", from: "3.0.0"),
        .package(url: "https://github.com/swift-kipple/Core", revision: "20c722bb11823d72b3c346ca0fad2888c5af8adf"),
        .package(url: "https://github.com/swift-kipple/Tools", revision: "4bc0d4cee521e5a7389d832b8fac45cdf4a867f2"),
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

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
        .library(name: "KippleUI", targets: ["KippleUI", "SafeNavigationKit"]),
        .library(name: "SafeNavigationKit", targets: ["SafeNavigationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.11.0")),
        .package(url: "https://github.com/Nirma/UIDeviceComplete", .upToNextMajor(from: "2.8.1")),
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

#if swift(>=5.5)
// Add Kipple Tools if possible.
package.dependencies.append(
    .package(url: "https://github.com/swift-kipple/Tools", from: "0.3.0")
)
#endif

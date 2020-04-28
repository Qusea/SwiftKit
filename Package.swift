// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "SwiftKit",
    platforms: [
        .iOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftKit",
            targets: ["SwiftKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "2.2.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"),
        .package(url: "https://github.com/danielsaidi/Mockery.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "SwiftKit",
            dependencies: []),
        .testTarget(
            name: "SwiftKitTests",
            dependencies: ["SwiftKit", "Quick", "Nimble", "Mockery"]),
    ]
)

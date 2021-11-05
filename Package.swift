// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DripKit",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "DripKit",
            targets: ["DripKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "DripKit",
            dependencies: []),
        .testTarget(
            name: "DripKitTests",
            dependencies: ["DripKit"]),
    ]
)

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
    targets: [
        .target(
            name: "DripKit",
            dependencies: [])
    ]
)

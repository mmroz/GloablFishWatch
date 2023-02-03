// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GlobalFishWatch",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "GlobalFishWatch",
            targets: ["GlobalFishWatch"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GlobalFishWatch",
            dependencies: []),
        .testTarget(
            name: "GlobalFishWatchTests",
            dependencies: ["GlobalFishWatch"],
            resources: [
                .copy("Resources/Fixtures")
            ]
        ),
    ]
)

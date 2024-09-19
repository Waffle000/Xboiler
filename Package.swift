// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.6
// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Xboiler",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "Xboiler",
            targets: ["Xboiler"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/yonaskolb/XcodeGen.git", from: "2.42.0"),
    ],
    targets: [
        .executableTarget(
            name: "Xboiler",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "XcodeGenKit", package: "XcodeGen"),
            ]
        ),
    ]
)


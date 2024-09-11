// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.6
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
        .package(url: "https://github.com/tuist/xcodeproj", from: "8.0.0"),
        .package(url: "https://github.com/jpsim/Yams", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Xboiler",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "XcodeProj", package: "xcodeproj"),
                "Yams"
            ]),
    ]
)


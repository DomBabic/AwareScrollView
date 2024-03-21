// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AwareScrollView",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AwareScrollView",
            targets: ["AwareScrollView"]),
    ],
    targets: [
        .target(
            name: "AwareScrollView")
    ]
)

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JMMaskTextField",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "JMMaskTextField", targets: ["JMMaskTextField"]),
    ],
    targets: [
        .target(name: "JMMaskTextField", dependencies: [])
    ]
)

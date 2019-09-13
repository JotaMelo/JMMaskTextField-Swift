// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JMMaskTextField",
    products: [
        .library(name: "JMMaskTextField", targets: ["JMMaskTextField"]),
    ],
    targets: [
        .target(name: "JMMaskTextField", path: "JMMaskTextField/Classes")
    ]
)

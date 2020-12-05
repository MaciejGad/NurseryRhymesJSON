// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NurseryRhymesJSON",
    dependencies: [
        .package(name: "Models", url: "https://github.com/MaciejGad/NurseryRhymesModels", .branch("main"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NurseryRhymesJSON",
            dependencies: ["Models"]),
        .testTarget(
            name: "NurseryRhymesJSONTests",
            dependencies: ["NurseryRhymesJSON", "Models"]),
    ]
)

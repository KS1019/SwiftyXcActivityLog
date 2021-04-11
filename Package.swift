// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyXcActivityLog",
    platforms: [
        .macOS(.v10_11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftyXcActivityLog",
            targets: ["SwiftyXcActivityLog"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Files", url: "https://github.com/JohnSundell/Files", .upToNextMajor(from: "4.2.0")),
        .package(name: "Gzip", url: "https://github.com/1024jp/GzipSwift", .upToNextMajor(from: "5.1.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftyXcActivityLog",
            dependencies: ["Files", "Gzip"]),
        .testTarget(
            name: "SwiftyXcActivityLogTests",
            dependencies: ["SwiftyXcActivityLog"]),
    ]
)

// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SceneKitDebugTools",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SceneKitDebugTools",
            targets: ["SceneKitDebugTools"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "MeshGenerator",
                 url: "https://github.com/heckj/MeshGenerator.git", .upToNextMajor(from: "0.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SceneKitDebugTools",
            dependencies: ["MeshGenerator"]
        ),
        .testTarget(
            name: "SceneKitDebugToolsTests",
            dependencies: ["SceneKitDebugTools"]
        ),
    ]
)
// Add the documentation compiler plugin if possible
#if swift(>=5.6)
    package.dependencies.append(
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    )
#endif

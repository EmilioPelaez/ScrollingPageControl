// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ScrollingPageControl",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "ScrollingPageControl", targets: ["ScrollingPageControl"])
    ],
    targets: [
        .target(name: "ScrollingPageControl"),
        .testTarget(name: "ScrollingPageControlTests", dependencies: ["ScrollingPageControl"])
    ]
)

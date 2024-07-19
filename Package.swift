// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "TrackerBlockingManager",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(
      name: "TrackerBlockingManager",
      targets: ["TrackerBlockingManager"]),
  ],
  dependencies: [
    .package(url: "https://github.com/duckduckgo/TrackerRadarKit.git", from: "2.1.2")
  ],
  targets: [
    .target(
      name: "TrackerBlockingManager",
      dependencies: ["TrackerRadarKit"]),
    .testTarget(
      name: "TrackerBlockingManagerTests",
      dependencies: ["TrackerBlockingManager"]),
  ]
)

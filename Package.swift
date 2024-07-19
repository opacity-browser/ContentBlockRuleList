// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "BlockRuleList",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(
      name: "BlockRuleList",
      targets: ["BlockRuleList"]),
  ],
  dependencies: [
    .package(url: "https://github.com/duckduckgo/TrackerRadarKit.git", from: "2.1.2")
  ],
  targets: [
    .target(
      name: "BlockRuleList",
      dependencies: ["TrackerRadarKit"]),
    .testTarget(
      name: "BlockRuleListTests",
      dependencies: ["BlockRuleList"]),
  ]
)

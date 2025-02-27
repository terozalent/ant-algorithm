// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "ant-algorithm",
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "AntAlgorithm")
  ]
)

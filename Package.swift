// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "CodexBinary",
  products: [
    .library(
      name: "CodexBinary",
      targets: ["CodexBinary"]
    ),
  ],
  targets: [
    .target(
      name: "CodexBinary",
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "CodexBinaryTests",
      dependencies: ["CodexBinary"]
    ),
  ]
)

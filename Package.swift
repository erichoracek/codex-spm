// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "CodexBinary",
  products: [
    .library(
      name: "CodexBinary",
      targets: ["CodexBinary"]
    ),
    .library(
      name: "CodexZshBinary",
      targets: ["CodexZshBinary"]
    ),
  ],
  targets: [
    .target(
      name: "CodexBinary",
      resources: [
        .process("Resources"),
      ]
    ),
    .target(
      name: "CodexZshBinary",
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "CodexBinaryTests",
      dependencies: ["CodexBinary"]
    ),
    .testTarget(
      name: "CodexZshBinaryTests",
      dependencies: ["CodexZshBinary"]
    ),
  ]
)

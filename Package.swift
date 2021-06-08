// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
 This source file is part of the Swift System open source project

 Copyright (c) 2020 Apple Inc. and the Swift System project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See https://swift.org/LICENSE.txt for license information
*/

import PackageDescription

var windowsPlatform: [Platform] = []
#if os(Windows)
windowsPlatform.append(.windows)
#endif

let targets: [Target] = [
  .target(
    name: "SystemPackage",
    dependencies: ["CSystem"],
    path: "Sources/System",
    cSettings: [
      .define("_CRT_SECURE_NO_WARNINGS", .when(platforms: windowsPlatform)),
    ],
    swiftSettings: [
      .define("SYSTEM_PACKAGE"),
      .define("ENABLE_MOCKING", .when(configuration: .debug))
    ]),
  .target(
    name: "CSystem",
    dependencies: []),
  .testTarget(
    name: "SystemTests",
    dependencies: ["SystemPackage"],
    swiftSettings: [
      .define("SYSTEM_PACKAGE")
    ]),
]

let package = Package(
    name: "swift-system",
    products: [
        .library(name: "SystemPackage", targets: ["SystemPackage"]),
    ],
    dependencies: [],
    targets: targets
)

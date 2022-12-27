// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModularsUI",
	platforms: [.iOS(.v15)],
    products: [
		.library(name: "AppLaunch", targets: ["AppLaunch"]),
		.library(name: "BoardsUI", targets: ["BoardsUI"]),
		.library(name: "BuildingsUI", targets: ["BuildingsUI"]),
		.library(name: "LightsUI", targets: ["LightsUI"]),
		.library(name: "ScenesUI", targets: ["ScenesUI"]),
		.library(name: "SharedUI", targets: ["ScenesUI"]),

    ],
    dependencies: [
		.package(name: "ModularsCore", path: "../ModularsCore"),
		.package(url: "https://github.com/benboecker/SFSymbol.git", from: "2.0.0"),
	],
    targets: [
		.target(name: "AppLaunch", dependencies: [
			.product(name: "Repositories", package: "ModularsCore"),

			"BoardsUI",
			"BuildingsUI",
			"LightsUI",
			"ScenesUI",
		]),
		.target(name: "BoardsUI", dependencies: [
			.product(name: "BoardConnection", package: "ModularsCore"),
			.product(name: "Constants", package: "ModularsCore"),
			.product(name: "DataTypes", package: "ModularsCore"),
			.product(name: "Repositories", package: "ModularsCore"),
			
			"SharedUI",
		]),
		.target(name: "BuildingsUI", dependencies: [
			.product(name: "Constants", package: "ModularsCore"),
			.product(name: "DataTypes", package: "ModularsCore"),
			.product(name: "Repositories", package: "ModularsCore"),
			
			"SharedUI",
		]),
		.target(name: "LightsUI", dependencies: [
			.product(name: "Constants", package: "ModularsCore"),
			.product(name: "DataTypes", package: "ModularsCore"),
			.product(name: "Repositories", package: "ModularsCore"),
			
			"BoardsUI",
			"SharedUI",
		]),
		.target(name: "ScenesUI", dependencies: [
			.product(name: "BoardConnection", package: "ModularsCore"),
			.product(name: "Constants", package: "ModularsCore"),
			.product(name: "DataTypes", package: "ModularsCore"),
			.product(name: "Repositories", package: "ModularsCore"),
			
			"SharedUI",
		]),
		.target(name: "SharedUI", dependencies: [
			.product(name: "Constants", package: "ModularsCore"),
		]),
	]
)

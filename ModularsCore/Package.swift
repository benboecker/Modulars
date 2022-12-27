// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModularsCore",
	platforms: [.iOS(.v15)],
    products: [
		.library(name: "BoardConnection", targets: ["BoardConnection"]),
		.library(name: "Constants", targets: ["Constants"]),
		.library(name: "DataTypes", targets: ["DataTypes"]),
		.library(name: "Repositories", targets: ["Repositories"]),
    ],
	dependencies: [
		.package(url: "https://github.com/palasthotel/ph-networking.git", from: "1.0.0" ),
	],
	targets: [
		.target(name: "BoardConnection", dependencies: [
			.product(name: "PHNetworking", package: "ph-networking"),

			"DataTypes",
		]),
		.target(name: "Constants"),
		.target(name: "DataTypes"),
		.target(name: "Repositories", dependencies: [
			"BoardConnection",
			"DataTypes",
		]),
	]
)

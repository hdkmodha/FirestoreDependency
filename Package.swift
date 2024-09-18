// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target.Dependency {
    
    public static var tca: Target.Dependency {
        return .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    }
    
    public static var firebase: Target.Dependency {
        return .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
    }
}

let package = Package(
    name: "FirestoreDependency",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FirestoreDependency",
            targets: ["FirestoreDependency"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .upToNextMajor(from: "1.10.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.0.0"))
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FirestoreDependency",
            dependencies: [
                .tca,
                .firebase
            ]
        ),

    ]
)

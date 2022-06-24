// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TableViewDataProvider",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "TableViewDataProvider", targets: ["TableViewDataProvider"])
    ],
    targets: [
        .target(
            name: "TableViewDataProvider",
            path: "Source"
        ),
    ]
)
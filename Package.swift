// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    products: [
        .library(name: "SQLite", targets: ["SQLite"]),
        .library(name: "SQLiteObjc", targets: ["SQLiteObjc"])],
    targets: [
        .target(name: "SQLite", 
                dependencies: [
                    .target(name: "SQLiteObjc"),
                ]),
        .target(name: "SQLiteObjc"),
        .testTarget(name: "SQLiteTests",
                    dependencies: [
                        .target(name:"SQLite"),
                    ],
                    path: "Tests/SQLiteTests")
    ]
)

#if os(Linux)
    package.dependencies = [.package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")]
    package.targets = [
        .target(name: "SQLite", exclude: ["Extensions/FTS4.swift", "Extensions/FTS5.swift"]),
        .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests", exclude: [
            "FTS4Tests.swift",
            "FTS5Tests.swift"
        ])
    ]
#endif

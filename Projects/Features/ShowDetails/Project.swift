import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "ShowDetails",
  dependencies: [
    .project(
      target: "UI",
      path: .relativeToRoot("Projects/Features/UI")
    ),
    .package(product: "RxCocoa"),
    .package(product: "RxDataSources"),
    .package(product: "RxSwift")
  ],
  interfaceFolder: "Interface",
  interfaceDependencies: [
    .project(
      target: "Shared",
      path: .relativeToRoot("Projects/Features/Shared")
    ),
    .project(
      target: "Persistence",
      path: .relativeToRoot("Projects/Features/Persistence")
    ),
    .project(
      target: "Networking",
      path: .relativeToRoot("Projects/Features/Networking")
    )
  ],
  testFolder: "Tests",
  testDependencies: [
    .package(product: "RxBlocking"),
    .package(product: "RxTest"),
    .package(product: "Quick"),
    .package(product: "Nimble"),
    .package(product: "SnapshotTesting")
  ]
)

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "ShowDetails",
  dependencies: [
    .project(
      target: "UI",
      path: .relativeToRoot("Projects/Features/UI")
    ),
    .project(
      target: "Networking",
      path: .relativeToRoot("Projects/Features/Networking")
    ),
    .project(
      target: "Shared",
      path: .relativeToRoot("Projects/Features/Shared")
    ),
    .project(
      target: "Persistence",
      path: .relativeToRoot("Projects/Features/Persistence")
    ),
    .project(
      target: "ReactiveKitUI",
      path: .relativeToRoot("Projects/ReactiveKitUI")
    ),
  ]
  // MARK: - TODO
  //,testFolder: "Tests"
)

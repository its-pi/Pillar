import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .required("author")
let organizationAttribute: Template.Attribute = .required("organization")
let testOptionsAttribute: Template.Attribute = .required("test-options")
let currentDateAttribute: Template.Attribute = .required("date")
let currentYearAttribute: Template.Attribute = .required("year")

let template = Template(
    description: "Default UIKit Template",

    attributes: [
        nameAttribute,
        authorAttribute,
        organizationAttribute,
        testOptionsAttribute,
        currentDateAttribute,
        currentYearAttribute,
    ],

    items: [
        .file(path: "Project.swift", templatePath: "Project.stencil"),
        .file(path: "Tuist/Package.swift", templatePath: "Package.stencil"),

        // Sources.
        .file(
            path: "{{ name }}/Sources/App/AppDelegate.swift",
            templatePath: "MyApp/Sources/App/AppDelegate.stencil"
        ),
        .file(
            path: "{{ name }}/Sources/App/SceneDelegate.swift",
            templatePath: "MyApp/Sources/App/SceneDelegate.stencil"
        ),
        .file(
            path: "{{ name }}/Sources/View/ViewController.swift",
            templatePath: "MyApp/Sources/View/ViewController.stencil"
        ),

        // Resources
        .directory(
            path: "{{ name }}",
            sourcePath: "MyApp/Resources"
        ),

        // Configs
        .file(
            path: "Configs/Debug.xcconfig",
            templatePath: "Configs/Debug.stencil"
        ),
        .file(
            path: "Configs/Release.xcconfig",
            templatePath: "Configs/Release.stencil"
        ),
        .file(
            path: "Configs/Team.xcconfig",
            templatePath: "Configs/Team.xcconfig"
        ),
        .file(
            path: "Configs/Team.example.xcconfig",
            templatePath: "Configs/Team.example.xcconfig"
        ),

        .file(path: "Makefile", templatePath: "Makefile.stencil"),

        .file(path: ".gitignore", templatePath: ".gitignore"),

        .string(
            path: "README.md",
            contents: "# \(nameAttribute)"
        ),
    ]
)

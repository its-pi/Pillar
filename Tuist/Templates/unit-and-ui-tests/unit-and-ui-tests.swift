import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .required("author")
let organizationAttribute: Template.Attribute = .required("organization")
let currentDateAttribute: Template.Attribute = .required("date")
let currentYearAttribute: Template.Attribute = .required("year")

let template = Template(
    description: "Default Unit and UI Tests Template",

    attributes: [
        nameAttribute,
        authorAttribute,
        organizationAttribute,
        currentDateAttribute,
        currentYearAttribute,
    ],

    items: [
        .file(
            path: "{{ name }}/Tests/Unit/{{ name }}Tests.swift",
            templatePath: "MyApp/Tests/Unit/MyAppTests.stencil"
        ),

        .file(
            path: "{{ name }}/Tests/UI/{{ name }}UITests.swift",
            templatePath: "MyApp/Tests/UI/MyAppUITests.stencil"
        ),
        .file(
            path: "{{ name }}/Tests/UI/{{ name }}UITestsLaunchTests.swift",
            templatePath: "MyApp/Tests/UI/MyAppUITestsLaunchTests.stencil"
        ),
    ]
)

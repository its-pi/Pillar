import ProjectDescription

private let name: String = "Pillar"
private let organization: String = "its-pi"

private let bundleId: String = "com.its-pi.pillar"
private let version: String = "0.0.1"
private let bundleVersion: String = "1"

private let destinations: Destinations = .iOS
private let deploymentTargets: DeploymentTargets = .iOS("15.0")

private let basePath: String = "Pillar"

let project = Project(
    name: name,
    organizationName: organization,
    options: .options(
        automaticSchemesOptions: .enabled(
            testingOptions: [.parallelizable, .randomExecutionOrdering]
        )
    ),
    packages: [],
    settings: Settings.settings(configurations: makeConfiguration()),
    targets: [
        .target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/Resources/**"],
            settings: baseSettings(),
            additionalFiles: [
                "README.md",
            ]
        ),
        .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).tests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["\(basePath)/Tests/Unit/**"],
            dependencies: [.target(name: name)],
            settings: baseSettings(),
        ),
        .target(
            name: "\(name)UITests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).uitests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["\(basePath)/Tests/UI/**"],
            dependencies: [.target(name: name)],
            settings: baseSettings(),
        ),
    ],
    schemes: [
        .scheme(
            name: "\(name)-UnitTests",
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                [
                    .testableTarget(target: "\(name)Tests")
                ],
                options: .options(coverage: true)
            )
        ),
        .scheme(
            name: "\(name)-UITests",
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                [
                    .testableTarget(target: "\(name)UITests")
                ],
                options: .options(coverage: false)
            )
        ),
        .scheme(
            name: "\(name)-AllTests",
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                [
                    .testableTarget(target: "\(name)Tests"),
                    .testableTarget(target: "\(name)UITests")
                ],
                options: .options(coverage: true)
            )
        ),
    ],
    fileHeaderTemplate: .string(
        """
        //
        // ___FILENAME___
        // ___PROJECTNAME___
        //
        // Created by ___FULLUSERNAME___ on ___DATE___.
        // Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
        //
        """
    )
)

/// Create extended plist for iOS
/// - Returns: info.plist
private func makeInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: Plist.Value] = [
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                    ],
                ],
            ],
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "UISupportedInterfaceOrientations~iphone": [
            "UIInterfaceOrientationPortrait",
        ],
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
        ],
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
    ]

    for (key, value) in other {
        extendedPlist[key] = value
    }

    return InfoPlist.extendingDefault(with: extendedPlist)
}

/// Create dev and release configuration
/// - Returns: Configuration Tuple
private func makeConfiguration() -> [Configuration] {
    let debug = Configuration.debug(
        name: "Debug", xcconfig: "Configs/Debug.xcconfig"
    )
    let release = Configuration.release(
        name: "Release", xcconfig: "Configs/Release.xcconfig"
    )

    return [debug, release]
}

private func baseSettings() -> Settings {
    var settings = SettingsDictionary()

    return Settings.settings(base: settings, configurations: [], defaultSettings: .recommended)
}

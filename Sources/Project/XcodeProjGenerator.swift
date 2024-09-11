//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation
import PathKit
import XcodeProj

class XcodeProjGenerator {
    func generateXcodeProject(appName: String, bundleId: String, platform: String, deploymentTarget: String, outputFolder: String, sourceFolder: String, plistPath: String) {
        do {
            let projectPath = Path(outputFolder) + "\(appName).xcodeproj"
            
            let pbxproj = PBXProj()

            let mainGroup = PBXGroup(children: [], sourceTree: .group, name: appName)
            pbxproj.add(object: mainGroup)

            let sourcesGroup = PBXGroup(children: [], sourceTree: .group, path: appName)
            pbxproj.add(object: sourcesGroup)
            mainGroup.children.append(sourcesGroup)

            let sourceFiles = try FileManager.default.contentsOfDirectory(atPath: sourceFolder)
            for file in sourceFiles where file.hasSuffix(".swift") {
                let fileReference = PBXFileReference(sourceTree: .group, path: file)
                pbxproj.add(object: fileReference)
                sourcesGroup.children.append(fileReference)
            }

            let plistFileReference = PBXFileReference(sourceTree: .group, path: "\(appName)/Info.plist")
            pbxproj.add(object: plistFileReference)
            mainGroup.children.append(plistFileReference)

            let mainTarget = PBXNativeTarget(name: appName, buildPhases: [], buildRules: [], dependencies: [], productType: .application)
            pbxproj.add(object: mainTarget)

            let sourcesBuildPhase = PBXSourcesBuildPhase()
            pbxproj.add(object: sourcesBuildPhase)
            mainTarget.buildPhases.append(sourcesBuildPhase)

            for fileReference in sourcesGroup.children.compactMap({ $0 as? PBXFileReference }) {
                let buildFile = PBXBuildFile(file: fileReference)
                pbxproj.add(object: buildFile)
                sourcesBuildPhase.files?.append(buildFile)
            }

            let productReference = PBXFileReference(sourceTree: .buildProductsDir, explicitFileType: "wrapper.application", path: "\(appName).app", includeInIndex: false)
            pbxproj.add(object: productReference)
       
            let frameworksBuildPhase = PBXFrameworksBuildPhase()
            pbxproj.add(object: frameworksBuildPhase)
            mainTarget.buildPhases.append(frameworksBuildPhase)

            let debugConfig = XCBuildConfiguration(name: "Debug")
            debugConfig.buildSettings = [
                "PRODUCT_NAME": "$(TARGET_NAME)",
                "PRODUCT_BUNDLE_IDENTIFIER": bundleId,
                "SDKROOT": platform == "iOS" ? "iphoneos" : "macosx",
                "DEPLOYMENT_TARGET": deploymentTarget,
                "SWIFT_VERSION": "5.0",
                "ARCHS": "$(ARCHS_STANDARD)",
                "ONLY_ACTIVE_ARCH": "NO",
                "INFOPLIST_FILE": "\(appName)/Info.plist",
                "EXECUTABLE_NAME": "$(PRODUCT_NAME)",
                "ALWAYS_SEARCH_USER_PATHS": "NO"
            ]
            pbxproj.add(object: debugConfig)

            debugConfig.buildSettings["CUSTOM_SETTING"] = "CustomValue"
            pbxproj.add(object: debugConfig)
            
            let releaseConfig = XCBuildConfiguration(name: "Release")
            releaseConfig.buildSettings = [
                "PRODUCT_NAME": "$(TARGET_NAME)",
                "PRODUCT_BUNDLE_IDENTIFIER": bundleId,
                "SDKROOT": platform == "iOS" ? "iphoneos" : "macosx",
                "DEPLOYMENT_TARGET": deploymentTarget,
                "SWIFT_VERSION": "5.0",
                "ARCHS": "$(ARCHS_STANDARD)",
                "ONLY_ACTIVE_ARCH": "NO",
                "INFOPLIST_FILE": "\(appName)/Info.plist",
                "EXECUTABLE_NAME": "$(PRODUCT_NAME)",
                "ALWAYS_SEARCH_USER_PATHS": "NO"
            ]
            pbxproj.add(object: releaseConfig)

            let buildConfigList = XCConfigurationList(buildConfigurations: [debugConfig, releaseConfig], defaultConfigurationName: "Debug")
            mainTarget.buildConfigurationList = buildConfigList
            pbxproj.add(object: buildConfigList)


            let projectObject = PBXProject(name: appName, buildConfigurationList: buildConfigList, compatibilityVersion: "Xcode 12.0", mainGroup: mainGroup, targets: [mainTarget])
            pbxproj.add(object: projectObject)

            pbxproj.rootObject = projectObject

            let project = XcodeProj(workspace: XCWorkspace(), pbxproj: pbxproj)
            try project.write(path: projectPath)
            
            print("Xcode project successfully generated at \(projectPath.string)")

            let scheme = XCScheme(name: appName, lastUpgradeVersion: "1310", version: "1.3")
            
            let buildableReference = XCScheme.BuildableReference(
                referencedContainer: projectPath.string,
                blueprint: mainTarget,
                buildableName: "\(appName).app",
                blueprintName: appName
            )
            
            let buildActionEntry = XCScheme.BuildAction.Entry(buildableReference: buildableReference, buildFor: [.running, .testing])
            scheme.buildAction = XCScheme.BuildAction(buildActionEntries: [buildActionEntry])

            scheme.launchAction = XCScheme.LaunchAction(
                runnable: XCScheme.BuildableProductRunnable(buildableReference: buildableReference),
                buildConfiguration: "Debug"
            )

            try scheme.write(path: projectPath + "\(appName).xcscheme", override: true)
            print("Xcode scheme generated at \(projectPath.string)")

        } catch {
            print("Gagal membuat Xcode project menggunakan xcodeproj: \(error)")
        }
    }


}

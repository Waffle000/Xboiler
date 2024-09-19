//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation
import PathKit
import XcodeProj
import XcodeGenKit
import ProjectSpec

class XcodeProjGenerator {
    func generateXcodeProject(appName: String, bundleId: String, platform: String, deploymentTarget: String, outputFolder: String, sourceFolder: String, plistPath: String) {
        do {
            let yamlFileName = "project.yml"
            let yamlContent = """
            name: \(appName)
            options:
              bundleIdPrefix: \(bundleId)
              deploymentTarget:
                \(platform): '\(deploymentTarget)'
            targets:
              \(appName):
                type: application
                platform: \(platform)
                sources: [\(appName)]
                resources: [\(appName)/Assets.xcassets]
                info:
                  path: "Info.plist"
                  properties:
                    CFBundleIdentifier: $(PRODUCT_BUNDLE_IDENTIFIER)
                    CFBundleVersion: "1.0"
                    CFBundleShortVersionString: "1.0"
                    CFBundleName: \(appName)
            """

            let yamlFilePath = Path(outputFolder) + yamlFileName
            try yamlContent.write(toFile: yamlFilePath.string, atomically: true, encoding: .utf8)
            print("YAML file created at \(yamlFilePath.string)")
            
            let projectPath = Path(outputFolder) + "\(appName).xcodeproj"
            let parsedProject: Project
            do {
                parsedProject = try Project(path: yamlFilePath)
            } catch {
                print("Error parsing YAML to Project: \(error)")
                throw error
            }
            
            let fileWriter = FileWriter(project: parsedProject)
            do {
                try fileWriter.writePlists()
            } catch {
                throw GenerationError.writingError(error)
            }

            
            let xcodeProject: XcodeProj
            do {
                let projectGenerator = ProjectGenerator(project: parsedProject)

                guard let userName = ProcessInfo.processInfo.environment["LOGNAME"] else {
                    throw GenerationError.missingUsername
                }

                xcodeProject = try projectGenerator.generateXcodeProject(in: Path(outputFolder), userName: userName)
            } catch {
                throw GenerationError.generationError(error)
            }

            do {
                let fileWriter = FileWriter(project: parsedProject)
                try fileWriter.writeXcodeProject(xcodeProject, to: projectPath)
                print("Created project at \(projectPath.string)")
            } catch {
                throw GenerationError.writingError(error)
            }

            do {
                try FileManager.default.removeItem(atPath: yamlFilePath.string)
                print("YAML file deleted at \(yamlFilePath.string)")
            } catch {
                print("Error deleting YAML file: \(error)")
                throw error
            }
            
        } catch {
            print("Failed create Xcode project: \(error)")
        }
    }
    
}

enum GenerationError: Error {
    case missingUsername
    case generationError(Error)
    case writingError(Error)
}

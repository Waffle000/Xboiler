//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation

class BoilerplateGenerator {
    func generateProject(from yamlData: YAMLData) {
        let outputFolder = yamlData.outputFolder
        let appName = yamlData.appName
        let mainViewName = yamlData.mainView
        let bundleId = yamlData.bundleId
        let platform = yamlData.platform
        let deploymentTarget = yamlData.deploymentTarget

        let outputURL = URL(fileURLWithPath: outputFolder)
        if !FileManager.default.fileExists(atPath: outputURL.path) {
            do {
                try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                print("Folder \(outputFolder) created successfully.")
            } catch {
                print("Failed to create folder \(outputFolder): \(error)")
                return
            }
        }

        let sourcesFolder = "\(outputFolder)/\(appName)"
        if !FileManager.default.fileExists(atPath: sourcesFolder) {
            do {
                try FileManager.default.createDirectory(atPath: sourcesFolder, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create folder \(appName): \(error)")
                return
            }
        }

        SwiftFileGenerator().generateSwiftFiles(from: yamlData, at: sourcesFolder)
        MainAppFileGenerator().generateMainAppFile(appName: appName, mainViewName: mainViewName, outputFolder: sourcesFolder)
        AssetCatalogGenerator().generateAssetCatalog(forApp: appName, at: sourcesFolder)
        XcodeProjGenerator().generateXcodeProject(appName: appName, bundleId: bundleId, platform: platform, deploymentTarget: deploymentTarget, outputFolder: outputFolder, sourceFolder: sourcesFolder, plistPath: "\(sourcesFolder)/Info.plist")
    }
}

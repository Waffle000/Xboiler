//
//  File.swift
//  
//
//  Created by Enrico Maricar on 19/09/24.
//

import Foundation

class AssetCatalogGenerator {
    func generateAssetCatalog(forApp appName: String, at outputFolder: String) {
        let assetsFolder = "\(outputFolder)/Assets.xcassets"

        if !FileManager.default.fileExists(atPath: assetsFolder) {
            do {
                try FileManager.default.createDirectory(atPath: assetsFolder, withIntermediateDirectories: true, attributes: nil)
                print("Assets.xcassets folder created at \(assetsFolder).")
            } catch {
                print("Failed to create Assets.xcassets folder: \(error)")
                return
            }
        }

        let appIconSetFolder = "\(assetsFolder)/AppIcon.appiconset"
        if !FileManager.default.fileExists(atPath: appIconSetFolder) {
            do {
                try FileManager.default.createDirectory(atPath: appIconSetFolder, withIntermediateDirectories: true, attributes: nil)
                print("AppIcon.appiconset folder created.")

                let contents = """
                {
                  "images": [
                    {
                      "idiom": "iphone",
                      "size": "60x60",
                      "scale": "2x"
                    },
                    {
                      "idiom": "iphone",
                      "size": "60x60",
                      "scale": "3x"
                    },
                    {
                      "idiom": "ipad",
                      "size": "76x76",
                      "scale": "1x"
                    }
                  ],
                  "info": {
                    "version": 1,
                    "author": "xcode"
                  }
                }
                """
                
                let contentsFilePath = "\(appIconSetFolder)/Contents.json"
                try contents.write(toFile: contentsFilePath, atomically: true, encoding: .utf8)
                print("Contents.json created for AppIcon.appiconset.")
                
            } catch {
                print("Failed to create AppIcon.appiconset or Contents.json: \(error)")
                return
            }
        }
    }
}

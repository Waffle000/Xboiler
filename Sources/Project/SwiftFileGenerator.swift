//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation
import ArgumentParser

class SwiftFileGenerator {
    func generateSwiftFiles(from yamlData: YAMLData, at outputPath: String) {
        let outputURL = URL(fileURLWithPath: outputPath)

        if let folders = yamlData.folders, !folders.isEmpty {
            generateFoldersRecursively(folders: folders, at: outputURL)
        } else {
            print("No folders to generate.")
        }

        if let files = yamlData.files, !files.isEmpty {
            generateFiles(files, at: outputURL)
        } else {
            print("No root files to generate.")
        }
    }

    private func generateFoldersRecursively(folders: [Folder], at currentURL: URL) {
        for folder in folders {
            let folderURL = currentURL.appendingPathComponent(folder.folderName ?? "Folder")
            createDirectory(at: folderURL)

            if let files = folder.files, !files.isEmpty {
                generateFiles(files, at: folderURL)
            } else {
                print("No files to generate in folder: \(folder.folderName ?? "Error")")
            }

            if let subfolders = folder.subfolders, !subfolders.isEmpty {
                generateFoldersRecursively(folders: subfolders, at: folderURL)
            } else {
                print("No subfolders in folder: \(folder.folderName ?? "Error")")
            }
        }
    }

    private func generateFiles(_ files: [File], at folderURL: URL) {
        for file in files {
            let fileName = "\(folderURL.path)/\(file.name).swift"
            let swiftCode: String

            switch file.type {
            case .view:
                swiftCode = """
                import SwiftUI

                struct \(file.name): View {
                    var body: some View {
                        \(file.content ?? "")
                    }
                }
                """
            case .class:
                let inheritancePart = generateInheritance(for: file)
                swiftCode = """
                import Foundation

                class \(file.name)\(inheritancePart) {
                    \(file.content ?? "")
                }
                """
            case .protocol:
                swiftCode = """
                protocol \(file.name) {
                    \(file.content ?? "")
                }
                """
            case .helper:
                swiftCode = file.content ?? ""
            }

            writeFile(fileName: fileName, content: swiftCode)
        }
    }

    private func generateInheritance(for file: File) -> String {
        guard let inherits = file.inherits else {
            return ""
        }

        var inheritanceString = ""
        if let superclass = inherits.superclass {
            inheritanceString += ": \(superclass)"
        }

        if let protocols = inherits.protocols, !protocols.isEmpty {
            if inheritanceString.isEmpty {
                inheritanceString += ": "
            } else {
                inheritanceString += ", "
            }
            inheritanceString += protocols.joined(separator: ", ")
        }

        return inheritanceString
    }

    private func createDirectory(at url: URL) {
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            print("Created directory: \(url.path)")
        } catch {
            print("Failed to create directory: \(url.path), error: \(error.localizedDescription)")
        }
    }

    private func writeFile(fileName: String, content: String) {
        do {
            try content.write(toFile: fileName, atomically: true, encoding: .utf8)
            print("Generated file: \(fileName)")
        } catch {
            print("Failed to write file: \(fileName), error: \(error.localizedDescription)")
        }
    }
}





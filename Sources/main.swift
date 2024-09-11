// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser

struct Generate: ParsableCommand {
    @Argument(help: "Access Path YAML.")
    var yamlFilePath: String
    
    func run() throws {
        do {
            if let yamlData = parseYAML(filePath: yamlFilePath) {
                ProjectGenerator().generateProject(from: yamlData)
            } else {
                throw ValidationError("Failed read YAML")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}

func fetchGitHubTag() -> String {
    let url = URL(string: "https://api.github.com/repos/Waffle000/Xboiler/tags")!
    var version = "Unknown"
    let semaphore = DispatchSemaphore(value: 0)

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let latestTag = json.first?["name"] as? String {
                version = latestTag
            }
        }
        semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    return version
}

struct XBoiler: ParsableCommand {
    static var version: String {
        return fetchGitHubTag()
    }

    static let configuration = CommandConfiguration(
        abstract: "XBoiler - Generate SwiftUI boilerplate from YAML",
        version: version,
        subcommands: [Generate.self],
        defaultSubcommand: Generate.self
    )
}

XBoiler.main()

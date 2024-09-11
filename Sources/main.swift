// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser

struct Generate: ParsableCommand {
    @Argument(help: "Path ke file YAML.")
    var yamlFilePath: String
    
    func run() throws {
        if let yamlData = parseYAML(filePath: yamlFilePath) {
            ProjectGenerator().generateProject(from: yamlData)
        } else {
            print("Gagal mem-parsing YAML.")
        }
    }
}

struct XBoiler: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "XBoiler - Generate SwiftUI boilerplate from YAML",
        subcommands: [Generate.self],
        defaultSubcommand: Generate.self
    )
}

XBoiler.main()

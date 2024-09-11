//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation

class SwiftFileGenerator {
    func generateSwiftFiles(for views: [View], at outputPath: String) {
        let outputURL = URL(fileURLWithPath: outputPath)

        for view in views {
            let fileName = "\(outputURL.path)/\(view.name).swift"
            let swiftCode = """
            import SwiftUI
            
            struct \(view.name): View {
                var body: some View {
                    \(view.content ?? "")
                }
            }
            """

            do {
                try swiftCode.write(toFile: fileName, atomically: true, encoding: .utf8)
                print("Generated file: \(fileName)")
            } catch {
                print("Failed to write file: \(fileName)")
            }
        }
    }
}

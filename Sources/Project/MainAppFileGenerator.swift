//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation

class MainAppFileGenerator {
    func generateMainAppFile(appName: String, mainViewName: String, outputFolder: String) {
        let appFileName = "\(outputFolder)/\(appName)App.swift"
        let appCode = """
        import SwiftUI
        
        @main
        struct \(appName)App: App {
            var body: some Scene {
                WindowGroup {
                    \(mainViewName)()
                }
            }
        }
        """
        
        do {
            try appCode.write(toFile: appFileName, atomically: true, encoding: .utf8)
            print("Generated file: \(appFileName)")
        } catch {
            print("Gagal menulis file: \(appFileName)")
        }
    }
}

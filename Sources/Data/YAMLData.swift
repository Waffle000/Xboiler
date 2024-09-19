//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation

struct YAMLData: Codable {
    let outputFolder: String
    let appName: String
    let mainView: String
    let bundleId: String
    let platform: String
    let deploymentTarget: String
    let device: String
    let files: [File]?
    let folders: [Folder]?
}

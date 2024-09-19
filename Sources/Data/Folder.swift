//
//  File 2.swift
//  
//
//  Created by Enrico Maricar on 19/09/24.
//

import Foundation

struct Folder: Codable {
    let folderName: String?
    let files: [File]?
    let subfolders: [Folder]?
}

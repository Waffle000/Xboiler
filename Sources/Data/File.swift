//
//  File.swift
//  
//
//  Created by Enrico Maricar on 19/09/24.
//

import Foundation

struct File: Codable {
    let name: String
    let type: FileType
    let content: String?
    let inherits: InheritanceData?
}

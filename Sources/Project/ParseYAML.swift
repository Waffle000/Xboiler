//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation
import Yams

func parseYAML(filePath: String) -> YAMLData? {
    guard let yamlString = try? String(contentsOfFile: filePath, encoding: .utf8) else {
        print("Gagal membaca file YAML.")
        return nil
    }
    return try? YAMLDecoder().decode(YAMLData.self, from: yamlString)
}

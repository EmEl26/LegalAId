//
//  Attorney.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/21/25.
//

import SwiftUI
import Foundation

struct Attorney: Identifiable, Codable {
    let id = UUID()
    let organization_name: String
    let website: String
    let phone: String?
    let hours: String?
    let services: String
    let borough_offices: [String: String]?
    let address: String?
    let addresses: [String]?
    let instagram: String?
    let tags: [String]
}

func decode_attorney(_ file: String) -> [Attorney] {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Faliled to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedFile = try? decoder.decode([Attorney].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loadedFile
    }

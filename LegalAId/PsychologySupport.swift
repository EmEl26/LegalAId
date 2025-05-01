//
//  PsychologySupport.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/21/25.
//

import SwiftUI
import CoreLocation
import Foundation

struct PsychologySupport: Identifiable, Codable {
    let id = UUID()
    let organization_name: String
    let address: String
    let general_info: String
    let tags: [String]
}

func decode_psych(_ file: String) -> [PsychologySupport] {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
        print("Failed to locate \(file) in bundle")
        return []
    }
    
    guard let data = try? Data(contentsOf: url) else {
        print("Failed to load file from \(file)")
        return []
    }
    
    let decoder = JSONDecoder()
    
    guard let loadedFile = try? decoder.decode([PsychologySupport].self, from: data) else {
        print("Failed to decode \(file)")
        return []
    }
    
    return loadedFile
}


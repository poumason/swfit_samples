//
//  DocItem.swift
//  DownloadAndReadApp
//
//  Created by POU LIN on 2024/2/21.
//

import Foundation

struct DocItem: Identifiable, Codable {
    let id: UUID = UUID()
    
    let title: String
    let description: String
}

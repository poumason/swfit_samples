//
//  TextItem.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/27.
//

import Foundation

class TextItem: Identifiable {
    var id: String = ""
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}

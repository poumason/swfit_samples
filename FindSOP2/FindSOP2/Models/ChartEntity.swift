//
//  ChartEntity.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import AppIntents

struct ChartEntity: AppEntity {
    static var defaultQuery = ChartEntityQuery()
    
    var id: UUID
    
    @Property(title: "Chart Name")
    var name: String
    
    @Property(title: "Description")
    var description: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Chart"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)",
                              subtitle: "\(description)")
    }
    
    init(id: UUID, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

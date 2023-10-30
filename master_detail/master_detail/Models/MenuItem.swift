//
//  MenuItem.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/18.
//

import Foundation

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var subMenuItems: [MenuItem]?
}

@Observable
class MenuItemView: Identifiable, Hashable {
    static func == (lhs: MenuItemView, rhs: MenuItemView) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
    
    var isFocus: Bool = false
    var isComplete: Bool = false
    var item: MenuItem
    let id: UUID
    
    init(item: MenuItem) {
        self.id = item.id
        self.item = item
    }
}

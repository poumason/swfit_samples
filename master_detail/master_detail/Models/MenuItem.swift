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

@Observable
class MenuItemViewStack: Hashable {
   
    static func == (lhs: MenuItemViewStack, rhs: MenuItemViewStack) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
    
    
    var stacks: [MenuItemView] = []
    var id: UUID
    
    init(id: UUID) {
        self.id = id
    }
    
    func feedMenuItems(items: [MenuItem]) -> Bool? {
        self.stacks = .init()
        for _item in items {
            self.stacks.append(MenuItemView(item: _item))
        }
        return true
    }
    
    func updateFocus(current:MenuItem.ID) {
        for _item in self.stacks {
            if _item.id == current {
                _item.isFocus = true
            } else {
                _item.isFocus = false
            }
        }
    }
}

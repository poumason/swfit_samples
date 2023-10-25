//
//  CoffeeEquipmentModel.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/18.
//

import Foundation

struct CoffeeEquipmenModel {
    let mainMenuItems = {
        
        // Sub-menu items for Espressco Machines
        let espressoMachineMenuItems = [ MenuItem(name: "Leva", image: "leva-x", subMenuItems: [ 
                                            MenuItem(name: "Leva X", image: "leva-x"),
                                            MenuItem(name: "Leva S", image: "leva-s") ]),
                                         MenuItem(name: "Strada", image: "strada-ep", subMenuItems: [ 
                                            MenuItem(name: "Strada EP", image: "strada-ep"),
                                            MenuItem(name: "Strada AV", image: "strada-av"),
                                            MenuItem(name: "Strada MP", image: "strada-mp"),
                                            MenuItem(name: "Strada EE", image: "strada-ee") ]),
                                         MenuItem(name: "KB90", image: "kb90"),
                                         MenuItem(name: "Linea", image: "linea-pb-x", subMenuItems: [ 
                                            MenuItem(name: "Linea PB X", image: "linea-pb-x"),
                                            MenuItem(name: "Linea PB", image: "linea-pb"),
                                            MenuItem(name: "Linea Classic", image: "linea-classic") ]),
                                         MenuItem(name: "GB5", image: "gb5"),
                                         MenuItem(name: "Home", image: "gs3", subMenuItems: [ 
                                            MenuItem(name: "GS3", image: "gs3"),
                                            MenuItem(name: "Linea Mini", image: "linea-mini") ])
        ]
        
        // Sub-menu items for Grinder
        let grinderMenuItems = [ MenuItem(name: "Swift", image: "swift"),
                                 MenuItem(name: "Vulcano", image: "vulcano"),
                                 MenuItem(name: "Swift Mini", image: "swift-mini"),
                                 MenuItem(name: "Lux D", image: "lux-d")
        ]
        
        // Sub-menu items for other equipment
        let otherMenuItems = [ MenuItem(name: "Espresso AV", image: "espresso-av"),
                               MenuItem(name: "Espresso EP", image: "espresso-ep"),
                               MenuItem(name: "Pour Over", image: "pourover"),
                               MenuItem(name: "Steam", image: "steam")
        ]
        
        // Top menu items
        let topMenuItems = [ MenuItem(name: "Espresso Machines", image: "linea-mini", subMenuItems: espressoMachineMenuItems),
                                MenuItem(name: "Grinders", image: "swift-mini", subMenuItems: grinderMenuItems),
                                MenuItem(name: "Other Equipments", image: "espresso-ep", subMenuItems: otherMenuItems)
                            ]
        
        return topMenuItems
    }()
    
    func subMenuItems(for id:MenuItem.ID) -> [MenuItem]? {
        guard let menuItem = mainMenuItems.first(where: { $0.id == id}) else { return nil }
        return menuItem.subMenuItems
    }
    
    func menuItem(for categoryId: MenuItem.ID, itemId: MenuItem.ID) -> MenuItem? {
        guard let subItems = subMenuItems(for: categoryId) else { return nil }
        guard let menuItem = subItems.first(where: {$0.id == itemId}) else { return nil }
        return menuItem
    }
}

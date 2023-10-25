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

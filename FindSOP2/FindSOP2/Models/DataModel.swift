//
//  DataModel.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import SwiftUI
import Observation

@Observable class DataModel: @unchecked Sendable{
    var target: String
    
    
    
    init() {
        self.target = ""
    }
}

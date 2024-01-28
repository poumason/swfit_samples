//
//  ChartEntityQuery.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/28.
//

import Foundation
import AppIntents


struct ChartEntityQuery: EntityQuery, EntityStringQuery {
    func entities(for identifiers: [UUID]) async throws -> [ChartEntity] {
//        return DataManager.shared.chartCategory.filter { _category in
//            identifiers.contains(_category.id)
//        }
        return DataManager.shared.chartCategory.compactMap { _category in
            return identifiers.contains(_category.id) ? _category : nil
        }
    }
    
    func suggestedEntities() async throws -> [ChartEntity] {
        return DataManager.shared.chartCategory
    }
    
    func entities(matching string: String) async throws -> [ChartEntity] {
        let  find = DataManager.shared.chartCategory.filter { _category in
            _category.name.contains(string)
        }
        print(find)
        return find
    }
}

//
//  TwoColumnSplitView.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/24.
//

import SwiftUI

struct TwoColumnSplitView: View {
    @State private var selectedCategoryId:MenuItem.ID?
    @State private var selectedItem:MenuItem?
    private var dataModel = CoffeeEquipmenModel()
    
    var body: some View {
        NavigationSplitView {
            List(dataModel.mainMenuItems, selection: $selectedCategoryId) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(item.name)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                }
            }
            .navigationTitle("Coffee")
        } content : {
            if let selectedCategoryId,
               let categoryItems = dataModel.subMenuItems(for: selectedCategoryId){
                List(categoryItems, selection:$selectedItem) { item in
                    NavigationLink(value: item) {
                        HStack {
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(item.name)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Please select a category")
            }
        } detail: {
            if let selectedItem {
                Image(selectedItem.image)
                    .resizable()
                    .scaledToFit()
            }else {
                Text("Please select an item")
            }
        }
    }
}

#Preview {
    TwoColumnSplitView()
}

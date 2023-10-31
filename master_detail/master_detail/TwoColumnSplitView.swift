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
    @State private var columnVisiblity = NavigationSplitViewVisibility.all
    @State private var pathStack: [MenuItem] = []
    //    @Environment(MenuItemViewStack.self) private var viewStack
    
    private var viewStacks: [MenuItemViewStack] = []
    
    private var dataModel = CoffeeEquipmenModel()
    private let parks = [
        Park(name: "park1", next: Park(name: "park2", next: Park(name: "park3")))
    ]
    
    var body: some View {
        //        @Bindable var _viewStack = viewStack
        NavigationSplitView(columnVisibility: $columnVisiblity) {
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
        }
        detail : {
            if let selectedCategoryId,
               let categoryItems = dataModel.subMenuItems(for: selectedCategoryId)
            //               let isView = _viewStack.feedMenuItems(items: categoryItems)
            {
                
                //                let _viewStack = viewStacks.first(where: { $0.id == selectedCategoryId }) ?? MenuItemViewStack(id: selectedCategoryId).feedMenuItems(items: categoryItems)
                let _viewStack = viewStacks.first(where: {
                    $0.id == selectedCategoryId
                }) ?? MenuItemViewStack(id: selectedCategoryId)
                let _ = _viewStack.feedMenuItems(items: categoryItems)
                //                List(categoryItems, selection:$selectedItem) { item in
                //                    NavigationLink(value: item) {
                //                        HStack {
                //                            Image(item.image)
                //                                .resizable()
                //                                .scaledToFit()
                //                                .frame(width: 50, height: 50)
                //                            Text(item.name)
                //                                .font(.system(.title3, design: .rounded))
                //                                .bold()
                //                        }
                //                    }
                //                }
                //                .listStyle(.plain)
                //                .navigationBarTitleDisplayMode(.inline)
                //                SplitViewWithStack()
                
                
                NavigationStack(path: $pathStack) {
                    MenuItemDetail(item: categoryItems[0], next: categoryItems[1], _stack: _viewStack, path: $pathStack)                    
                        .navigationDestination(for: MenuItem.self) { _item in
                            let _index = categoryItems.firstIndex(of: _item) ?? 0
                            if _index == 0 {
                                MenuItemDetail(item: _item, next: categoryItems[_index + 1],
                                               _stack: _viewStack, path: $pathStack)
                            } else {
                                if (_index + 1) >= categoryItems.count {
                                    
                                    MenuItemDetail(item: _item, previous: categoryItems[_index - 1],
                                                   _stack: _viewStack, path: $pathStack)
                                } else {
                                    MenuItemDetail(item: _item,
                                                   next: categoryItems[_index + 1], previous: categoryItems[_index - 1],
                                                   _stack: _viewStack, path: $pathStack)
                                }
                            }
                            
                        }
                }
                .toolbar(.hidden, for: .automatic)
                
            } else {
                Text("Please select a category")
            }
        }
        //    detail: {
        //        if let selectedItem {
        //            Image(selectedItem.image)
        //                .resizable()
        //                .scaledToFit()
        //            //            SplitViewWithStack()
        //
        //        }else {
        //            Text("Please select an item")
        //        }
        //    }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    TwoColumnSplitView()
}

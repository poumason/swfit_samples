//
//  MenuItemDetail.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/30.
//

import SwiftUI

struct MenuItemDetail: View {
    var item: MenuItem
    var next: MenuItem?
    var previous: MenuItem?
//    @Environment(MenuItemViewStack.self) private var stack
    var _stack: MenuItemViewStack
    @Binding var path: [MenuItem]
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
//        @Bindable var _stack = stack
        VStack{
            ProgressStepView(steps: _stack.stacks, path: $path)
            ScrollView {
                
                Text("\(item.name)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                HStack{
                    if let _previous = previous {
                        NavigationLink("Go \(_previous.name)", value: _previous)
                    }
                    Spacer()
                    if let _next = next {
                        NavigationLink("Go \(_next.name)", value: _next)
                    }
                    Spacer()
                    Button("open window") {
//                        openWindow(value: item.id)
                        openWindow(value: Transcation(id: item.id, path: item.name))
                    }
                }
            }
        }
        .toolbar(.hidden, for: .automatic)
//        .navigationTitle(item.name)
        
        .onAppear() {
            _stack.updateFocus(current: item.id)
        }
    }
}

//
//#Preview {
//    MenuItemDetail(item: MenuItem(name: "Hello", image: "globl"), _stack: MenuItemViewStack(id: UUID()))
//}

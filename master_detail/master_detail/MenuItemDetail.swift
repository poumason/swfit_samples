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
    @Environment(MenuItemViewStack.self) private var stack
    
    var body: some View {
        @Bindable var _stack = stack
        
        VStack {
            ProgressStepView(steps: _stack.stacks)
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
            }
        }
        .navigationTitle(item.name)
        .onAppear() {
            _stack.updateFocus(current: item.id)
        }
    }
}


#Preview {
    MenuItemDetail(item: MenuItem(name: "Hello", image: "globl"))
}

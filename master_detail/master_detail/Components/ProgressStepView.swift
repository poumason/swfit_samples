//
//  ProgressStepView.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/28.
//

import Foundation
import SwiftUI

struct ProgressStepView: View {
    var title: String?
    @State var steps: [MenuItemView]
//    @Binding var path: [MenuItem]
    
    init(steps: [MenuItemView], title: String? = nil) {
        self.steps = steps
//        self.path = path
        self.title = title
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if let title {
                Text(title)
                    .font(.title3)
            }
            ForEach(steps) { step in
                Button{
                    step.isFocus = true
                    for _step in steps {
                        if _step != step {
                            _step.isFocus = false
                        }
                    }
                } label: {
                    Text(step.item.name)
                        .font(step.isFocus ? .title: .title3)
                }
                .foregroundColor(step.isComplete ? .green: .white)
                if step != steps.last {
                    Rectangle()
                        .frame(width: 50, height: 10)
                        .foregroundColor(step.isComplete ? .green: .gray)
                }
            }
        }.padding(20)
    }
}

#Preview{
    ProgressStepView(steps: [
        MenuItemView(item: MenuItem(name: "step1", image: "gobe")),
        MenuItemView(item: MenuItem(name: "step2", image: "gobe"))]
    )
}



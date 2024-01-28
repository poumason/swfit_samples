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
    var steps: [MenuItemView]
    @Binding var path: [MenuItem]
    
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
                    
                    if let itemIndex = path.firstIndex(where: { $0.id == step.id}) {
                        path.removeLast(path.count - itemIndex - 1)
                    } else {
                        // must add previous items
                        for _step in steps {
                            if let _ = path.first(where: {$0.id == _step.id}) {
                                continue
                            } else if let _ = path.first(where: {$0.id == step.id}) {
                                break
                            } else {
                                path.append(_step.item)
                            }
                        }
                    }
                } label: {
                    Text(step.item.name)
                        .font(step.isFocus ? .title: .title3)
                        .foregroundStyle(step.isFocus ? .yellow : .white)
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

//#Preview{
//    ProgressStepView(steps: [
//        MenuItemView(item: MenuItem(name: "step1", image: "gobe")),
//        MenuItemView(item: MenuItem(name: "step2", image: "gobe"))]   )
//}



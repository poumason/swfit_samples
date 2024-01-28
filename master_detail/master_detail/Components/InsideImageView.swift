//
//  InsideImageView.swift
//  master_detail
//
//  Created by POU LIN on 2023/11/2.
//

import SwiftUI

struct InsideImageView: View {
    var id: MenuItem.ID
    var data: Transcation
    
    var body: some View {
        VStack {
            Text("value: \(id)")
            Text("data: \(data.id), \(data.path)")
        }
    }
}

#Preview {
    InsideImageView(id: UUID(), data: Transcation(id: UUID(), path: "hello"))
}

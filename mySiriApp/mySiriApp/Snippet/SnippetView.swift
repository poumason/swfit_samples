//
//  SnippetView.swift
//  mySiriApp
//
//  Created by POU LIN on 2024/1/18.
//

import Foundation
import SwiftUI

struct SnippetView: View {
    let render: UIImage
    
    var body: some View {
        Image(uiImage: render)
    }
}

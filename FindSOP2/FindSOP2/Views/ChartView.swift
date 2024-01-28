//
//  ChartView.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        VStack {
            Spacer()            
            Chart {
                BarMark(
                    x: .value("Day", "Monday"),
                    y: .value("Steps", 6019)
                )
                BarMark(
                    x: .value("Day", "Tuesday"),
                    y: .value("Steps", 7200)
                ) }
            Spacer()
        }
    }
}

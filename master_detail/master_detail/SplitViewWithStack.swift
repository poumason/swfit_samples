//
//  SplitViewWithStack.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/25.
//

import SwiftUI


struct SplitViewWithStack: View {
    @State private var presentedParks: [Park] = []
    
    private let parks = [
        Park(name: "park1", next: Park(name: "park2", next: Park(name: "park3")))
    ]
    
    var body: some View {
        NavigationStack(path: $presentedParks){
            ParkDetails(park: parks.first!)
                .navigationDestination(for: Park.self) { park in
                    ParkDetails(park: park)
                }
                .navigationTitle("title")
        }
    }
}

struct ParkDetails: View {
    @State var park: Park
    
    var body: some View {
        VStack {
            Text("\(park.id)_\(park.name)")
            if let next = park.next {
                NavigationLink("go Next", value: next)
            }
        }
    }
}

class Park: Identifiable, Hashable {
    static func == (lhs: Park, rhs: Park) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let name: String
    var next: Park?
    
    init(name: String, next: Park? = nil) {
        self.name = name
        self.next = next
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(id)_\(name)")
    }
}

#Preview {
    SplitViewWithStack()
}

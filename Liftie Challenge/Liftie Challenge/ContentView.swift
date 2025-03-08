//
//  ContentView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/5/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Fetch all Lift entities from Core Data
        @FetchRequest(
            entity: LCLift.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \LCLift.name, ascending: true)]
        ) var lifts: FetchedResults<LCLift>
    
    var body: some View {
        NavigationStack {
            List(lifts, id: \.self) {lift in
                HStack{
                    Text(lift.name ?? "Electric chair")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(lift.beerd ? "Beerd" : "Not Beerd", value: lift)
                        .frame(width: 100, alignment: .trailing)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(lift.beerd ? Color.green : Color.fromRGB(255, 144, 179))
            }
            .navigationTitle("Chairs")
            .navigationDestination(for: LCLift.self){ lift in
                LiftView(lift: lift)
            }
        }
    }
}

extension Color {
    static func fromRGB(_ red: Int, _ green: Int, _ blue: Int) -> Color {
        return Color(red: Double(red) / 255.0,
                     green: Double(green) / 255.0,
                     blue: Double(blue) / 255.0)
    }
}

#Preview {
    ContentView()
}

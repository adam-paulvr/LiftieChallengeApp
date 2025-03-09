//
//  MapLiftView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/8/25.
//

import SwiftUI
import CoreData
import UniformTypeIdentifiers


struct MapLiftView: View {
    // Fetch all Lift entities from Core Data
        @FetchRequest(
            entity: LCLift.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \LCLift.name, ascending: true)]
        ) var lifts: FetchedResults<LCLift>
    
    var body: some View {
        NavigationStack {
            // Scrollable background image
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                ZStack {
                    Image("MountainMap") // Replace with your image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1200, height: 725) // Adjust size to make it scrollable
                        .overlay(
                            Color.clear
                                .contentShape(Rectangle()) // Ensures the whole area is tappable
                                .onTapGesture { location in
                                    print("Tapped at x: \(location.x), y: \(location.y)")
                                }
                        )
                    Spacer()
                    ForEach(lifts) { lift in
                        NavigationLink(destination: LiftView(lift: lift)){
                            Circle()
                                .fill(lift.beerd ? Color.green.opacity(0.7) : Color.fromRGB(255, 144, 179).opacity(0.7))
                                .frame(width: 40, height: 40)
                        }
                        .position(x: CGFloat(lift.xVal), y: CGFloat(lift.yVal))
                    }
                }
            }
            .navigationTitle("Hydration Map")
        }
    }
}

// Destination View for Navigation
struct DetailView: View {
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapLiftView()
    }
}

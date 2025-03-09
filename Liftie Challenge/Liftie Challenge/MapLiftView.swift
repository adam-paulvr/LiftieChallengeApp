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
    
    @State private var showResetConfirmation = false // Controls modal visibility

    let dataController = DataController.shared

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
                    
                    // added purely to idenfity where on the map to place the buttons
//                        .overlay(
//                            Color.clear
//                                .contentShape(Rectangle()) // Ensures the whole area is tappable
//                                .onTapGesture { location in
//                                    print("Tapped at x: \(location.x), y: \(location.y)")
//                                }
//                        )
                    
                    Spacer()
                    ForEach(lifts) { lift in
                        NavigationLink(destination: LiftView(lift: lift)){
                            Circle()
                                .fill(lift.beerd ? Color.green.opacity(0.7) : Color.fromRGB(255, 144, 179).opacity(0.7))
                                .frame(width: 40, height: 40)
                        }
                        .position(x: CGFloat(lift.xVal), y: CGFloat(lift.yVal))
                    }
                    Button(action: {
                        showResetConfirmation = true // Show confirmation modal
                    })
                    {
                        Text("Rehydrate")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red.opacity(0.4))
                            .cornerRadius(10)
                    }
                    .position(x: 1092, y: 673)
                    .padding()
                
                }
            }
            .navigationTitle("Hydration Map")
            .alert("Confirm Rehydration?", isPresented: $showResetConfirmation) {
                Button("Cancel", role: .cancel) { } // Just closes modal
                Button("Yes Rehydrate", role: .destructive) {
                    // reset data for test devices
                    dataController.loadPersistentStores() // Resets the persistent store
                                                          // Will likely need more granular control over data
                    showResetConfirmation = false // Close modal after reset
                }
            } message: {
                Text("Are you sure you want to rehydrate? All current records of hydration will be deleted.")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapLiftView()
    }
}

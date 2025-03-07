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

struct LiftView: View {
    var lift: LCLift
    
    var body: some View {
        Text(lift.name ?? "Electric chair")
        if(lift.beerd){
            Text("Chair has been Beerd")
        }else{
            Text("Chair has not been Beerd")
        }
        
        VStack{
            // Button to take pic
            Button(action: {
                // Action for button tap
                print("Photo incrimination tapped")
            }) {
                Text("Incriminate with photo")
                    .font(.headline)
                    .foregroundColor(.white) // Text color
                    .padding() // Padding around the text
                    .frame(maxWidth: .infinity) // Make the button stretch across the screen
                    .background(Color.blue) // Button background color
                    .cornerRadius(15) // Rounded corners
                    .padding() // Padding outside the button
            }
            .frame(height: 50) // Set the button's height
            // Button to initiate recording
            Button(action: {
                // Action for button tap
                print("Video incrimination tapped")
            }) {
                Text("Incriminate with video")
                    .font(.headline)
                    .foregroundColor(.white) // Text color
                    .padding() // Padding around the text
                    .frame(maxWidth: .infinity) // Make the button stretch across the screen
                    .background(Color.red) // Button background color
                    .cornerRadius(15) // Rounded corners
                    .padding() // Padding outside the button
            }
            .frame(height: 50) // Set the button's height
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

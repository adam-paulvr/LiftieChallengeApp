//
//  ContentView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(LiftData.lifts, id: \.self) {lift in
                HStack{
                    Text("\(lift.liftName)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(lift.hasBeenBeerd ? "Beerd" : "Not Beerd", value: lift)
                        .frame(width: 100, alignment: .trailing)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(lift.hasBeenBeerd ? Color.green : Color.fromRGB(255, 144, 179))
            }
            .navigationTitle("Chairs")
            .navigationDestination(for: Lift.self){ lift in
                LiftView(lift: lift)
            }
        }
    }
}

struct LiftView: View {
    var lift: Lift
    
    var body: some View {
        Text(lift.liftName)
        if(lift.hasBeenBeerd){
            Text("Chair has been Beerd")
        }else{
            Text("Chair has not been Beerd")
        }
        // Button to initiate recording
        Button(action: {
            // Action for button tap
            print("Chug button tapped")
        }) {
            Text("Chug")
                .font(.headline)
                .foregroundColor(.white) // Text color
                .padding() // Padding around the text
                .frame(maxWidth: .infinity) // Make the button stretch across the screen
                .background(Color.blue) // Button background color
                .cornerRadius(25) // Rounded corners
                .padding() // Padding outside the button
        }
        .frame(height: 50) // Set the button's height
        
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

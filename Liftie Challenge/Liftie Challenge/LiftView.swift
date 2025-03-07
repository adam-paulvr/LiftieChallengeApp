//
//  LiftView.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/7/25.
//


import SwiftUI
import CoreData

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

#Preview {
    LiftView(lift: .init(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)))
}

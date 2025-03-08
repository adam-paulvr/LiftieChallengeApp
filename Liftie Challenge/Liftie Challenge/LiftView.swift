//
//  LiftView.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/7/25.
//


import SwiftUI
import CoreData
import UniformTypeIdentifiers


struct LiftView: View {
    var lift: LCLift
    @State private var isCameraPresented = false
    @State private var videoURL: URL?
    
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
                isCameraPresented.toggle()
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
        .sheet(isPresented: $isCameraPresented) {
            CameraPicker(isPresented: $isCameraPresented) { url in
                // Handle the recorded video URL
                self.videoURL = url
            }
        }
    }
}

#Preview {
    LiftView(lift: .init(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)))
}

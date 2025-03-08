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
        VStack{
            
            Text(lift.name ?? "Electric chair")
            
            if(lift.beerd){
                Text("Chair has been Beerd")
            }else{
                Text("Chair has not been Beerd")
            }
            VStack{
                // Button to initiate recording
                Button(action: {
                    // Action for button tap
                    print("Video incrimination tapped")
                    isCameraPresented.toggle()
                }) {
                    Text("Chug")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 200)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding()
            }
            .sheet(isPresented: $isCameraPresented) {
                CameraPicker(isPresented: $isCameraPresented) { url in
                    // Handle the recorded video URL
                    self.videoURL = url
                }
            }
        }
    }
}

#Preview {
    LiftView(lift: .init(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)))
}

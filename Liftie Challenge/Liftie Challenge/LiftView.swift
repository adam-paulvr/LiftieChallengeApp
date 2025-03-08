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
    @State private var media: MediaType?
    
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
            .fullScreenCover(isPresented: $isCameraPresented) {
                CameraPicker(isPresented: $isCameraPresented) { media in
                    self.media = media
                }
            }
        }
        
        /**START-DELETE: Placeholder proving media is returned **/
        
        // Handling and displaying the returned media
        if let media = media {
            switch media {
            case .photo(let image):
                // Display the photo if it's an image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            case .video(let url):
                // Display the video URL
                Text("Video URL: \(url.absoluteString)")
            }
        }
        
        /**END-DELETE: Placeholder proving media is returned **/
    }
}

#Preview {
    LiftView(lift: .init(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)))
}

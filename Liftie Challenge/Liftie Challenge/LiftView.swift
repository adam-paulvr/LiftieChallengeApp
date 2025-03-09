//
//  LiftView.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/7/25.
//


import SwiftUI
import CoreData
import UniformTypeIdentifiers
import _AVKit_SwiftUI


struct LiftView: View {
    @ObservedObject var lift: LCLift
    @State private var isCameraPresented = false
    
    var body: some View {
        
        // Lift title
        Text(lift.name ?? "Electric chair")
            .font(.title)
            .padding(.leading)
            .foregroundColor(lift.beerd ? .green : .red)
            .frame(maxWidth: .infinity)
            .padding(10)
        
        VStack{
            
            // Check-in status
            ZStack{
                Text(lift.beerd ? "CHUGGED" : "UNCHUGGED")
                    .fontWeight(.bold)
                    .font(.system(size: 45))
                    .colorInvert()
                    .padding(15)
                    .shadow(radius: 10) // Flavortown
                    .multilineTextAlignment(.center)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Apply a rounded rectangle outline
                    .stroke(Color.white, lineWidth: 5) // Set outline color and width
            )
            .padding(.top, 50)
            .shadow(radius: 10) // Flavortown
            .rotationEffect(.degrees(-7)) // Apply a 10-degree rotation
            
            
            VStack{
                if lift.beerd {
                    if let pictureURLString = lift.pictureURL {
                        if let pictureURL = URL(string: pictureURLString) {
                            ImageCardView(url: pictureURL)
                        }
                    } else if let videoURLString = lift.videoURL {
                        if let videoURL = URL(string: videoURLString) {
                            VideoCardView(url: videoURL)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Reset lift data
                        lift.beerd = false
                        // TODO: Delete any media. We're just gonna let it build up lmao.
                        lift.pictureURL = nil
                        lift.videoURL = nil
                    }) {
                        Text("I lied. Unchug.")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, minHeight: 70)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5) // Flavortown
                    }
                    .padding(.horizontal, 20) // Add horizontal padding around the button
                } else {
                    // Button to initiate recording
                    Button(action: {
                        // Action for button tap
                        print("Chug tapped")
                        isCameraPresented.toggle()
                    }) {
                        Text("Chug")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(lift.beerd ? .green : .red)
                            .padding()
                            .frame(width: 250, height: 250)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
            .padding(.top)
            .fullScreenCover(isPresented: $isCameraPresented) {
                CameraPicker(isPresented: $isCameraPresented) { media in
                    switch media {
                        case .photo(let imageURL):
                        lift.pictureURL = imageURL.absoluteString
                    case .video(let videoURL):
                        lift.videoURL = videoURL.absoluteString
                    }
                    lift.beerd = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(lift.beerd ? Color.green : Color.red)
        .animation(.easeInOut(duration: 0.3), value: lift.beerd)
    }
}

// For showing a square image.
struct ImageCardView: View {
    let url: URL
    
    var body: some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                AsyncImage(url: url) { image in
                            image
                                .resizable()          // Makes the image resizable
                                .scaledToFill()        // Ensures the aspect ratio is preserved
                                .clipped()
                        } placeholder: {
                            ProgressView() // Placeholder while loading
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: 50, height: 50)
                        }
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 10)
            .padding(20)
    }
}

struct VideoCardView: View {
    let url: URL
    
    var body: some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                VideoPlayerView(videoURL: url)
                    .scaledToFill()
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 10)
            .padding(20)
    }
}

#Preview {
    LiftView(lift: .init(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)))
}

//
//  for.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/7/25.
//


import SwiftUI
import AVFoundation
import UIKit

// Enum for ease of passing back either an image or video.
enum MediaType {
    case photo(URL)
    case video(URL)
}

// Step 1: Create a UIViewControllerRepresentable struct for UIImagePickerController
struct CameraPicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraPicker

        init(parent: CameraPicker) {
            self.parent = parent
        }

        // Delegate method to handle when the user finishes recording a video
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let mediaURL = info[.mediaURL] as? URL {
                // Copy the video to permanent storage and pass back via closure.
                if let newVideoURL = MediaUtils.copyVideoToPermanentStorage(from: mediaURL) {
                    print("Video is saved at: \(newVideoURL)")
                    parent.didChug?(.video(mediaURL))
                } else {
                    print("Failed to save the video.")
                }
            } else if let image = info[.originalImage] as? UIImage {
                // Save image to permanent storage and pass back via closure.
                let fileName = UUID().uuidString + ".png"
                if let savedImageURL = MediaUtils.saveImageToPermanentStorage(image: image, fileName: fileName) {
                    print("Image saved successfully at: \(savedImageURL)")
                    parent.didChug?(.photo(savedImageURL))
                } else {
                    print("Failed to save the image.")
                }
            }
            parent.isPresented = false // Dismiss the picker
        }

        // Delegate method for when the user cancels the recording
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }

    // Step 2: Bindings and properties
    @Binding var isPresented: Bool
    var didChug: ((MediaType) -> Void)?

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.mediaTypes = [
            UTType.image.identifier,
            UTType.movie.identifier
        ]
        picker.cameraCaptureMode = .video // Set the camera mode to video
        picker.videoQuality = .typeHigh // Set video quality (optional)
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed for the camera
    }
}


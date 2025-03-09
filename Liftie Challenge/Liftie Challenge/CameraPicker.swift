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
    case photo(UIImage)
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
                // If it's a video, pass the URL back using the didChug closure
                parent.didChug?(.video(mediaURL))
            } else if let image = info[.originalImage] as? UIImage {
                // If it's a photo, pass the image back using the didChug closure
                parent.didChug?(.photo(image))
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


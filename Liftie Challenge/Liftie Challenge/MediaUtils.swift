//
//  MediaUtils.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/8/25.
//


import UIKit
import AVFoundation

struct MediaUtils {
    
    // Save UIImage to permanent storage
    static func saveImageToPermanentStorage(image: UIImage, fileName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("Unable to find documents directory.")
            return nil
        }
        
        let imageURL = documentsDirectory.appendingPathComponent(fileName)
        
        guard let imageData = image.pngData() else {
            print("Failed to convert image to PNG data.")
            return nil
        }
        
        do {
            try imageData.write(to: imageURL)
            print("Image saved at: \(imageURL)")
            return imageURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }

    // Save video to permanent storage
    static func copyVideoToPermanentStorage(from url: URL) -> URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("Unable to find documents directory.")
            return nil
        }

        let videoFileName = UUID().uuidString + ".mov"  // You can change extension if needed
        let destinationURL = documentsDirectory.appendingPathComponent(videoFileName)

        do {
            try fileManager.copyItem(at: url, to: destinationURL)
            print("Video copied to: \(destinationURL)")
            return destinationURL
        } catch {
            print("Error copying video: \(error)")
            return nil
        }
    }
}

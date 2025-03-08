import SwiftUI
import _AVKit_SwiftUI
import AVFoundation

struct VideoPlayerView: View {
    let videoURL: URL
    @State private var player: AVPlayer?
    
    var body: some View {
        // Create an AVPlayer instance
        VideoPlayer(player: player)
            .onAppear {
                // Initialize the player when the view appears
                player = AVPlayer(url: videoURL)
                player?.play()
                
                // Set the video to loop
                player?.actionAtItemEnd = .none // Prevent automatic pause when video ends
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
                    player?.seek(to: .zero) // Restart the video when it finishes
                    player?.play() // Play the video again
                }
            }
            .onDisappear {
                // Pause the video when the view disappears
                player?.pause()
            }
            // Hack: there is no significance to magic number 42 here. If you provide aspect ratio with
            // 1/x, where x > 1, the video fills the width of its container with no black bars on the side.
            // We need this so we can fill our square video view. No other way works, and I'm not asking any questions.
            .aspectRatio(1/42, contentMode: .fill)
            .clipped()
    }
}


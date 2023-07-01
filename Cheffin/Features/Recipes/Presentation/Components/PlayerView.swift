//
//  PlayerView.swift
//  Cheffin
//
//  Created by Martinus Andika Novanawa on 30/06/23.
//
import SwiftUI
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    let mediaUrl: String
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        print("\(type(of: self)) \(#function)")
        guard let playerView = uiView as? LoopingPlayerUIView else {
            return
        }
        
        if playerView.url != mediaUrl {
            playerView.url = mediaUrl
            playerView.updatePlayer(with: mediaUrl)
        }
    }

    func makeUIView(context: Context) -> UIView {
        print("\(type(of: self)) \(#function)")
        return LoopingPlayerUIView(frame: .zero, url: self.mediaUrl)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    var url: String

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, url: String) {
        print("\(type(of: self)) \(#function)")
        self.url = url
        super.init(frame: frame)
        
        setupPlayer(with: url)
    }
    
    func setupPlayer(with url: String) {
        // Load the resource
        let fileUrl = URL(string: url)!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
         
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        // Start the movie
        player.play()
    }
    
    func updatePlayer(with url: String) {
        playerLayer.player?.pause()
        playerLayer.removeFromSuperlayer()
        
        setupPlayer(with: url)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

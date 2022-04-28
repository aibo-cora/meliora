//
//  Watching.swift
//  Nexus (iOS)
//
//  Created by Yura on 4/5/22.
//

import SwiftUI
import Joint
import AVKit

struct Watching: View {
    let streamer: Streamer
    let session: Session?
    
    public var player = AVQueuePlayer()
    
    var body: some View {
        CustomVideoPlayer(player: player)
            .onAppear() {
                session?.jointSession?.configurePlayer(watching: streamer, using: player)
                player.play()
            }
            .onDisappear() {
                player.pause()
            }
            .ignoresSafeArea()
            .frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
            .background(Color.gray)
    }
}

class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

struct CustomVideoPlayer: UIViewRepresentable {
    let player: AVQueuePlayer

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.player = player
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) { }
}

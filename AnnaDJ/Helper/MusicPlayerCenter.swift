//
//  MusicPlayerCenter.swift
//  AnnaDJ
//
//  Created by 陳逸煌 on 2023/1/13.
//

import Foundation
import AVFoundation

public class MultipleAudioPlayer {
        
    private var audioPlayers: [String:AVAudioPlayer] = [:]
    private var currentPlayer = 0
    private let playerDelegate = MultipleAudioPlayerObjCShim()
    
    public convenience init(keyFilenames: [String]) throws {
        
        var dict: [String: URL] = [:]
        
        for name in keyFilenames {
            if let fileURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
                dict[name] = fileURL
            }
        }

        
        try self.init(dict: dict)
    }
    
    public init(dict: [String: URL]) throws {
        #if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(watchOS)
        if #available(iOS 3.0, macCatalyst 13.0, tvOS 10.0, watchOS 3.0, *) {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        #endif
        for key in dict.keys {
            if let url = dict[key] {
                let player = try AVAudioPlayer(contentsOf: url)
                player.delegate = self.playerDelegate
                self.audioPlayers[key] = player
            }
        }

        
    }
    
    // MARK: Public functions
    
    
    public func play(id: String) {

        if let player = audioPlayers[id] {
            if player.isPlaying {
                player.currentTime = 0
                player.play()
            } else {
                player.play()
            }
        }
    }
    
    public func stop() {
        for key in self.audioPlayers.keys {
            if let player = self.audioPlayers[key] {
                player.stop()
            }
        }
    }
}


private protocol MultipleAudioPlayerObjCDelegate: AnyObject {
    func avPlayerDidFinishPlaying()
}

private class MultipleAudioPlayerObjCShim: NSObject, AVAudioPlayerDelegate {
    weak var delegate: MultipleAudioPlayerObjCDelegate?
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.avPlayerDidFinishPlaying()
    }
}

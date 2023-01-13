//
//  MusicPlayerCenter.swift
//  AnnaDJ
//
//  Created by 陳逸煌 on 2023/1/13.
//

import Foundation
import AVFoundation

public class MultipleAudioPlayer {
        
    private var audioPlayers: [AVAudioPlayer] = []
    private var currentPlayer = 0
    private let playerDelegate = MultipleAudioPlayerObjCShim()
    
    public convenience init(filenames: [String]) throws {
        let fileURLs: [URL] = filenames.map { filename in
            let nsFilename = filename as NSString
            let filePrefix = nsFilename.deletingPathExtension
            guard let fileURL = Bundle.main.url(forResource: filePrefix, withExtension: "mp3") else {
               print("Main bundle does not contain file")
                return URL(string: "")!
            }
            return fileURL
        }
        try self.init(fileURLs: fileURLs)
    }
    
    public init(fileURLs: [URL]) throws {
        var players: [AVAudioPlayer] = []
        #if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(watchOS)
        if #available(iOS 3.0, macCatalyst 13.0, tvOS 10.0, watchOS 3.0, *) {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        #endif
        for url in fileURLs {
            let player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self.playerDelegate
            players.append(player)
        }
        
        self.audioPlayers = players
    }
    
    // MARK: Public functions
    
    public func playRandom() {
        play(index: Int.random(in: 0..<audioPlayers.count))
    }
    
    public func play(index: Int = 0) {
        guard index < audioPlayers.count else {
            fatalError("index of audio file outside range of files")
        }
        
        if audioPlayers[index].isPlaying {
            audioPlayers[index].currentTime = 0
            audioPlayers[index].play()
        } else {
            audioPlayers[index].play()

        }
    }
    
    public func stop() {
        for player in audioPlayers {
            player.stop()
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

//
//  AudioManagerViewModel.swift
//  FootballChants
//
//  Created by Danil Lomaev on 11.07.2021.
//

import AVKit
import Foundation

class AudioManagerViewModel {
    private var chantAudioPlayer: AVAudioPlayer?

    func playback(_ team: Team) {
        if team.isPlaying {
            chantAudioPlayer?.stop()
        } else {
            guard let path = Bundle.main.path(forResource: "\(team.id.chantFile)", ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            DispatchQueue.global().async { [weak self] in
                do {
                    self?.chantAudioPlayer = try AVAudioPlayer(contentsOf: url)
                    self?.chantAudioPlayer?.numberOfLoops = -1
                    self?.chantAudioPlayer?.prepareToPlay()
                    self?.chantAudioPlayer?.play()
                } catch {
                    debugPrint("error")
                }
            }
        }
    }
}

//
//  PlaySound.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

//Play chime on start screen
import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Error. No audio file found.")
        }
    }
}
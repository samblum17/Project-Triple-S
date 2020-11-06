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

func playSound(sound: String, type: String, status: Bool) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            if status {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            } else {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.pause()
            }
        } catch {
            print("Error. No audio file found.")
        }
    }
}

func playInfiniteSound(sound: String, type: String, status: Bool) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            if status {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            audioPlayer?.numberOfLoops = -1
            } else {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.pause()
            }
        } catch {
            print("Error. No audio file found.")
        }
    }
}

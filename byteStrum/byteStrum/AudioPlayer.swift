//
//  AudioPlayer.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//  This file contains AI generated code.


import AVFoundation
import MidiParser

class AudioPlayer {
    private var audioPlayer: AVAudioPlayer?
    private var midiPlayer: AVMIDIPlayer?
    private var isPlaying = false
    private var currentSong: String?
    private let soundBankURL: URL = URL(
        fileURLWithPath: resourcesPath + "FluidR3_GM.sf2")

    var files: [URL] = []

    // Play a song (MP3 or MIDI)
    func play(song filePath: String) {
        guard let fileURL = URL(string: filePath) else {
            return
        }

        do {
            if let currentSong = self.currentSong, currentSong != filePath {
                stop()  // Stop the current song if different
            }

            if fileURL.pathExtension.lowercased() == "mid"
                || fileURL.pathExtension.lowercased() == "midi"
            {
                // MIDI file handling
                let midiData = try Data(contentsOf: fileURL)
                midiPlayer = try AVMIDIPlayer(
                    data: midiData, soundBankURL: soundBankURL)
                midiPlayer?.play { [weak self] in
                    self?.isPlaying = false
                }
                isPlaying = true
                self.currentSong = filePath
            }
        } catch {
            print("Error playing file: \(error)")
        }
    }

    // Fetch MP3 and MIDI files from the directory
    func fetchSongs() {
        guard let directoryURL = URL(string: songsPath) else {
            return
        }

        let fileManager = FileManager.default

        do {
            // Get all the files in the directory
            let files = try fileManager.contentsOfDirectory(
                at: directoryURL,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles)

            // Filter for MP3 and MIDI files
            let supportedFiles = files.filter {
                let ext = $0.pathExtension.lowercased()
                return ext == "mid" || ext == "midi"
            }

            self.files = supportedFiles

        } catch {
            print("Error fetching songs: \(error)")
        }
    }

    // Pause the current song
    func pause() {
        if isPlaying {
            if let audioPlayer = audioPlayer {
                audioPlayer.pause()
            } else if let midiPlayer = midiPlayer {
                midiPlayer.stop()
            }
            isPlaying = false
        }
    }

    // Resume the current song
    func resume() {
        if !isPlaying {
            if let audioPlayer = audioPlayer {
                audioPlayer.play()
            } else if let midiPlayer = midiPlayer {
                midiPlayer.play { [weak self] in
                    self?.isPlaying = false
                }
            }
            isPlaying = true
        }
    }

    // Stop the current song
    func stop() {
        if let audioPlayer = audioPlayer {
            audioPlayer.stop()
        } else if let midiPlayer = midiPlayer {
            midiPlayer.stop()
        }
        isPlaying = false
    }

    // Change the song (stop the current one and play a new one)
    func changeSong(to newSongPath: String) {
        stop()  // Stop the current song
        play(song: newSongPath)  // Play the new song
    }

    // Check if the player is currently playing
    func isCurrentlyPlaying() -> Bool {
        return isPlaying
    }

    // MARK - Midi data processor
    func getTrackNotes() -> [MidiNoteTrack] {

        guard
            let midiData: Data = try? Data(
                contentsOf: URL(string: currentSong!)!)
        else {
            fatalError()
        }

        let midi = MidiData()
        midi.load(data: midiData)

        
        return midi.noteTracks
        
    }

}



//
//  main.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import Foundation
import AVFoundation

// Path constants
let basePath: String = "/Users/aluno-18/Documents/Agatha/byteStrum/byteStrum/byteStrum/"
let resourcesPath = basePath + "resources/"
let songsPath = basePath + "/songs/"
let defaultMusic = "file://" + resourcesPath + "faded.mid"

// Music constants
let synthPath = resourcesPath + "synth.mp3"
let powerUpPath = resourcesPath + "powerUp.mp3"

// Players
let musicPlayer = AudioPlayer()
let hitEffect = AudioPlayer()
let specialEffects = AudioPlayer()

// Game
var game: ByteStrumGame? = nil
repeat {
    game = ByteStrumGame()
    game?.start()
} while game?.reloadGame ?? false


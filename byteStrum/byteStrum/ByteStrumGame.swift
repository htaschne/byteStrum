//
//  ByteStrumGame.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import Foundation

class ByteStrumGame: Game {

    enum GameState {
        case mainMenu, gameScreen, gameOver, chooseSong
    }

    var notes: [Note] = []

    // Player Info
    var score: Int = 0
    var player: String = ""

    // Input
    var lastKeyPressed: String? = nil
    var beforeLastKP: String? = nil
    let keyQuartesMap = ["a", "s", "d", "f"]

    // Dimentions
    var width: Int { terminal.canvasWidth }
    var height: Int { terminal.canvasHeight }
    var quarterSize: Int { terminal.canvasWidth / 4 }

    // Game Info
    var currentState: GameState = GameState.mainMenu
    var lastState: GameState?
    var currentSong: String?
    var notesQueue: DispatchQueue = DispatchQueue(label: "notes.queue")
    
    var reloadGame: Bool = false

    override func draw() {
        switch currentState {
        case .mainMenu:
            mainMenuDraw()
        case .gameScreen:
            gameScreenDraw()
        case .chooseSong:
            chooseSongDraw()
        case .gameOver:
            break
        }
    }

    override func loop() {
        switch currentState {
        case .mainMenu:
            mainMenuLoop()
        case .gameScreen:
            gameScreenLoop()
        case .chooseSong:
            chooseSongLoop()
        case .gameOver:
            break
        }
    }
    

    override func processInput(_ key: String) {
        lastKeyPressed = key
        if key == " " {
            self.reloadGame = true
            self.isRunning = false
            musicPlayer.stop()
        }


    }
}


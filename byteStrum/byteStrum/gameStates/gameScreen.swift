//
//  gameScreen.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import Foundation

extension ByteStrumGame {
    func gameScreenDraw() {
        let header = [
            " ____  _  _  ____  ____  ____  ____  ____  _  _  _  _",
            "(  _ \\( \\/ )(_  _)(  __)/ ___)(_  _)(  _ \\/ )( \\( \\/ )",
            " ) _ ( )  /   )(   ) _) \\___ \\  )(   )   /) \\/ (/ \\/ \\",
            "(____/(__/   (__) (____)(____/ (__) (__\\_)\\____/\\_)(_/",
        ]

        // Header
        for (xx, line) in header.enumerated() {
            for (yy, char) in line.enumerated() {
                terminal.draw(x: yy + 1, y: xx + 1, symbol: String(char))
            }
        }

        // Player
        for (xx, char) in "Player: Default".enumerated() {
            terminal.draw(
                x: xx + header[0].count + 5, y: 2, symbol: String(char))
        }

        for (xx, char) in "Score: \(score)".enumerated() {
            terminal.draw(
                x: xx + header[0].count + 5, y: 4, symbol: String(char))
        }

        // Borders
        for y in 5..<height {
            terminal.draw(x: 0, y: y, symbol: "│")
            terminal.draw(x: width - 1, y: y, symbol: "│")

            for i in [1, 2, 3] {
                terminal.draw(x: quarterSize * i, y: y, symbol: "|")
            }
        }

        for x in 0..<width {
            terminal.draw(x: x, y: 5, symbol: "─")
            terminal.draw(x: x, y: height - 1, symbol: "─")
        }

        terminal.draw(x: 0, y: 5, symbol: "┌")
        terminal.draw(x: width - 1, y: 5, symbol: "┐")
        terminal.draw(x: 0, y: height - 1, symbol: "└")
        terminal.draw(x: width - 1, y: height - 1, symbol: "┘")

        for note in notes {
            note.draw(&terminal, quarterSize)
        }

        if keyQuartesMap.contains(beforeLastKP ?? "") {
            if let quarter = keyQuartesMap.firstIndex(
                of: beforeLastKP ?? "")
            {

                for i in 0...quarterSize {
                    terminal.draw(
                        x: i + quarterSize * quarter, y: height - 1,
                        symbol: "x".colorByQuarter(quarter: quarter + 1))
                }
            }
        }

    }

    func gameScreenLoop() {
        if !musicPlayer.isCurrentlyPlaying() {
            currentSong = currentSong ?? defaultMusic
            musicPlayer.play(song: currentSong!)
            let trackNotes = musicPlayer.getTrackNotes()

            for track in trackNotes {
                for (i, note) in track.enumerated() {
                    // summons a new note 2 seconds before it needs to be pressed
                    self.notesQueue.asyncAfter(
                        deadline: .now() + note.timeStamp.inSeconds - 2.0
                    ) {
                        self.notes.append(Note(quarter: (i % 4) + 1))
                    }
                }
            }
        }

        for note in notes {
            if keyQuartesMap.contains(lastKeyPressed ?? "")
                && note.quarter
                    == keyQuartesMap.firstIndex(of: lastKeyPressed ?? "")! + 1
            {

                if note.hitNote(height) {
                    note.yPos = Double(height*3)
                    score += 1
                    break
                }

            }

            note.update(canvasHeight: self.height)

            // remove the notes that leave the screen
            while (notes.first?.yPos ?? 0.0) > Double(height) {
                notes.remove(at: 0)
            }
        }

        beforeLastKP = lastKeyPressed
        lastKeyPressed = nil

        guard musicPlayer.isCurrentlyPlaying() else {
            currentState = .gameOver
            return
        }
    }
}

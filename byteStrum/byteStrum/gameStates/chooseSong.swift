//
//  mainMenu.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import Foundation

extension ByteStrumGame {

    func chooseSongDraw() {
        let title = [
            "      ██████╗ ██╗   ██╗████████╗███████╗      ",
            "      ██╔══██╗╚██╗ ██╔╝╚══██╔══╝██╔════╝      ",
            "      ██████╔╝ ╚████╔╝    ██║   █████╗        ",
            "      ██╔══██╗  ╚██╔╝     ██║   ██╔══╝        ",
            "      ██████╔╝   ██║      ██║   ███████╗      ",
            "      ╚═════╝    ╚═╝      ╚═╝   ╚══════╝      ",
            "                                              ",
            " ███████╗████████╗██████╗ ██╗   ██╗███╗   ███╗",
            " ██╔════╝╚══██╔══╝██╔══██╗██║   ██║████╗ ████║",
            " ███████╗   ██║   ██████╔╝██║   ██║██╔████╔██║",
            " ╚════██║   ██║   ██╔══██╗██║   ██║██║╚██╔╝██║",
            " ███████║   ██║   ██║  ██║╚██████╔╝██║ ╚═╝ ██║",
            " ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝",
        ]

        

        
        
        
        // Header
        for (y, line) in title.enumerated() {
            for (x, char) in line.enumerated() {
                terminal.draw(
                    x: x + width / 2 - line.count / 2, y: y + height / 4,
                    symbol: String(char).green())
            }
        }

        var names: [String] = []
        if names.isEmpty {
            musicPlayer.fetchSongs()
        }
        names = Array(musicPlayer.files.map({ $0.lastPathComponent }).prefix(5))
        
        // Header
        for (y, line) in names.enumerated() {
            let newline = String(y + 1) + " " + line
            for (x, char) in newline.enumerated() {
                terminal.draw(
                    x: x + width / 4, y: height - 10 + y,
                    symbol: String(char).bold())
            }
        }

        // Borders
        for y in 0..<height {
            terminal.draw(x: 0, y: y, symbol: "│")
            terminal.draw(x: width - 1, y: y, symbol: "│")

        }

        for x in 0..<width {
            terminal.draw(x: x, y: 0, symbol: "─")
            terminal.draw(x: x, y: height - 1, symbol: "─")
        }

        terminal.draw(x: 0, y: 0, symbol: "┌")
        terminal.draw(x: width - 1, y: 0, symbol: "┐")
        terminal.draw(x: 0, y: height - 1, symbol: "└")
        terminal.draw(x: width - 1, y: height - 1, symbol: "┘")
    }

    func chooseSongLoop() {
        var songs: [String] = []
        if songs.isEmpty {
            musicPlayer.fetchSongs()
        }

        songs = Array(musicPlayer.files.map({ $0.absoluteString }).prefix(5))
        songs.append(defaultMusic)

        if let lastKeyPressed {
            switch lastKeyPressed {
            case "1":
                currentSong = songs[0]
            case "2":
                currentSong = songs[1]
            case "3":
                currentSong = songs[2]
            case "4":
                currentSong = songs[3]
            case "5":
                currentSong = songs[4]
            default:
                currentSong = songsPath
            }
            currentState = GameState.gameScreen
        }
    }
}

//
//  mainMenu.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import Foundation

extension ByteStrumGame {
    func mainMenuDraw() {
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

        let options = [
            "1. Start a new game",
            "2. Choose song",
            "3. Quit game",
        ]

        // Header
        for (y, line) in options.enumerated() {
            for (x, char) in line.enumerated() {
                terminal.draw(
                    x: x + width / 4, y: height - 10 + y,
                    symbol: String(char).bold())
            }
        }

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

    func mainMenuLoop() {
        if let lastKeyPressed {
            switch lastKeyPressed {
            case "1":
                currentState = GameState.gameScreen
            case "2":
                self.lastKeyPressed = nil
                currentState = GameState.chooseSong
            case "3":
                exit(0)
            default:
                break
            }

        }
    }
}

//
//  Note.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

import ColorizeSwift

class Note {
    var yPos: Double
    var duration: Double
    var quarter: Int
    var height: Int
    var symbol: String {
        "█".colorByQuarter(quarter: quarter)
    }
    
    init(quarter: Int) {
        self.yPos = 4
        self.duration = 2
        self.quarter = quarter
        self.height = 2
    }
    

    func update(canvasHeight: Int) {
        yPos += (Double(canvasHeight)/duration) * Double(Game.updateInterval)/1000.0
    }

    func draw(_ terminal: inout Terminal, _ quarterSize: Int) {
        for xOffset in 1...(quarterSize - 1) {
            let x = xOffset + (quarter - 1) * quarterSize
            for yOffset in 0...(height - 1) {
                var y = Int(Double(yOffset) + yPos)
                y = y < 6 ? 6 : y
                terminal.draw(
                    x: x,
                    y: y,
                    symbol: symbol)
            }
        }
    }

    func hitNote(_ canvasHeight: Int) -> Bool {
        let tolerance = 2
        return Int(yPos) < (canvasHeight + tolerance)  // has not left the screen
            && Int(yPos) + height > (canvasHeight - tolerance)  // the bottom part is in range

    }
}

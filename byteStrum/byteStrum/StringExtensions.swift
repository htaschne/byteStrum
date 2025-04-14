//
//  StringExtensions.swift
//  byteStrum
//
//  Created by Agatha Schneider and Adriel de Souza
//

extension String {
    func colorByQuarter(quarter: Int) -> String {
        switch quarter {
        case 1:
            return self.red()
        case 2:
            return self.blue()
        case 3:
            return self.yellow()
        case 4:
            return self.green()
        default:
            return self
        }
        
    }
}

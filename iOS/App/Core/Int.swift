//
//  Int.swift
//  iOS
//

import Foundation

extension Int {
    
    var formatingString: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand * 10) / 10)K"
        }
        
        return "\(self)"
    }
}

//
//  String.swift
//  iOS
//

import Foundation

extension String {
    
    var isEmail: Bool {
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
            .evaluate(with: self)
    }
}

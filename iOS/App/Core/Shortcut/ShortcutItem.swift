//
//  ShortcutItem.swift
//  iOS
//

import UIKit

struct ShortcutItem {
    
    let title: String
    
    let subTitle: String?
    
    let icon: String
    
    let handle: (_: UIWindow) -> Void
}

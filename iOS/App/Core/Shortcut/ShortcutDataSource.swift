//
//  ShortcutDataSource.swift
//  iOS
//

import Foundation

class ShortcutDataSource {
    private(set) var items: [ShortcutItem] = []
    
    func setupShortcuts() {
        items = [
            ShortcutItem(title: String(localized: "Explore"), subTitle: String(localized: "find new items"), icon: "search", handle: { window in
                if let tabBarController = window.rootViewController as? AppTabBarController {
                    tabBarController.selectedIndex = 1
                }
            }),
            ShortcutItem(title: String(localized: "Profile"), subTitle: nil, icon: "user", handle: { window in
                if let tabBarController = window.rootViewController as? AppTabBarController {
                    tabBarController.selectedIndex = 4
                }
            })
        ]
    }
}

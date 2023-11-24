//
//  ShortcutManager.swift
//  iOS
//

import UIKit

class ShortcutManager {
    
    var dataSource: ShortcutDataSource
    
    init(dataSource: ShortcutDataSource) {
        self.dataSource = dataSource
        self.dataSource.setupShortcuts()
    }
    
    func preformAction(window: UIWindow?, shortcutItem: UIApplicationShortcutItem) {
        guard let string = shortcutItem.type.split(separator: ".").last, let index = Int(string), let window = window else { return }
        if index < dataSource.items.count {
            dataSource.items[index].handle(window)
        }
    }
    
    func create() {
        guard let product_id = Bundle.main.bundleIdentifier else { return }
        var shortcutItems: [UIApplicationShortcutItem] = []
        for (index, item) in dataSource.items.enumerated() {
            let shortcut = UIApplicationShortcutItem(
                type: "\(product_id).action.\(index)",
                localizedTitle: item.title,
                localizedSubtitle: item.subTitle,
                icon: UIApplicationShortcutIcon(templateImageName: item.icon)
            )
            shortcutItems.append(shortcut)
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }
}

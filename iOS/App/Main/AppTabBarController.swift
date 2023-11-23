//
//  AppTabBarController.swift
//  iOS
//

import UIKit

class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = false
        
        viewControllers = [
            createNavigationController(icon: "home", activeIcon: "home-selected"),
            createNavigationController(icon: "search", activeIcon: "search"),
            createNavigationController(icon: "media", activeIcon: "media"),
            createNavigationController(icon: "reels", activeIcon: "reels-selected"),
            createNavigationController(icon: "user", activeIcon: "user-selected")
        ]
    }
    
    func createNavigationController(icon: String, activeIcon: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        // .withTintColor(.label)
        navController.tabBarItem.image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: activeIcon)?.withRenderingMode(.alwaysOriginal)

        return navController
    }
    
    // MARK: Vibrate on Tap
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController {
            if navController.topViewController != nil {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
            }
        }
    }
    
    // MARK: Show Media Controller
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let mediaController = UINavigationController(rootViewController: UIViewController())
            mediaController.modalPresentationStyle = .overFullScreen
            present(mediaController, animated: true)

            return false
        }

        return true
    }
}

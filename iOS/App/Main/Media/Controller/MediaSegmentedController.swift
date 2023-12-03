//
//  MediaSegmentedController.swift
//  iOS
//

import UIKit

class MediaSegmentedController: UIViewController {
    
    private lazy var viewControllers: [UIViewController] = []
    
    fileprivate var lastDisplayedViewControllerIndex: Int?
    
    private lazy var controls: UISegmentedControl = {
        let view = UISegmentedControl()
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayViewController(0)
    }

    @objc
    func handleSegment(_ segmentControl: UISegmentedControl) {
        var lastDisplayedIndex: Int? = nil

        if let i = self.lastDisplayedViewControllerIndex {
            lastDisplayedIndex = i
        }

        displayViewController(segmentControl.selectedSegmentIndex)

        if let j = lastDisplayedIndex {
            hideViewController(j)
        }
    }

    fileprivate func displayViewController(_ segmentViewControllerIndex: Int) {
        let viewController = viewControllers[segmentViewControllerIndex]
        addChild(viewController)
        view.addSubviews(viewController.view, controls)
        viewController.view.makeLayout(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        controls.makeLayout(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: UIScreen.main.bounds.width / 4, bottom: 35, right: UIScreen.main.bounds.width / 4), size: .init(width: UIScreen.main.bounds.width / 2, height: 40))
        viewController.didMove(toParent: self)
        lastDisplayedViewControllerIndex = controls.selectedSegmentIndex
    }

    fileprivate func hideViewController(_ viewControllerIndex: Int) {
        let viewController = self.viewControllers[viewControllerIndex]

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

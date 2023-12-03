//
//  MediaSelection.swift
//  iOS
//

import UIKit

class MediaSelection: UIView {
    
    var navigationHeight: CGFloat = 0
    
    fileprivate lazy var selectionNavigation = SelectionNavigation()
    fileprivate lazy var zoomable = Zoomable()
    fileprivate lazy var selectionControl = SelectionControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(selectionNavigation, zoomable, selectionControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func updateAlbumName(title: String) {
        selectionControl.albumButton.setTitle(title, for: .normal)
    }
    
    func setImage(_ photo: UIImage) {
        zoomable.setImage(photo)
    }
    
    private func setupConstraints() {
        selectionNavigation.makeLayout(top: nil, leading: leadingAnchor, bottom: zoomable.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: navigationHeight))
        
        zoomable.makeLayout(top: selectionNavigation.bottomAnchor, leading: leadingAnchor, bottom: selectionControl.topAnchor, trailing: trailingAnchor, size: .init(width: 0, height: UIScreen.main.bounds.width))
        
        selectionControl.makeLayout(top: zoomable.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: navigationHeight))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

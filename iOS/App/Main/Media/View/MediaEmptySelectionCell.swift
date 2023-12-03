//
//  MediaEmptySelectionCell.swift
//  iOS
//

import UIKit

class MediaEmptySelectionCell: UIView {
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "camera.viewfinder")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        image.makeLayout(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

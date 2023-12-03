//
//  MediaCollectionViewCell.swift
//  iOS
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    private lazy var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.makeLayout(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    func configure(thumb: UIImage) {
        image.image = thumb
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

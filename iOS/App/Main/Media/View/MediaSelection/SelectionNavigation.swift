//
//  SelectionNavigation.swift
//  iOS
//

import UIKit

class SelectionNavigation: UIView {
    
    lazy var closeButton: UIButton = {
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)

        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(String(localized: "Next"), for: .normal)
        btn.setTitleColor(UIColor(hex: "#0095f6"), for: .normal)
        
        return btn
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Create Post")
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(closeButton, nextButton, titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        closeButton.makeLayout(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 6, right: 0), size: .init(width: 0, height: 32))
        nextButton.makeLayout(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 16), size: .init(width: 0, height: 32))
        titleLabel.makeLayout(centerX: centerXAnchor, centerY: centerYAnchor)
        titleLabel.makeLayout(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 6, right: 0), size: .init(width: 0, height: 32))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

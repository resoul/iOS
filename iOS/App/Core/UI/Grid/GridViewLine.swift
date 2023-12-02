//
//  GridViewLine.swift
//  iOS
//

import UIKit

final class GridViewLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .white.withAlphaComponent(0.6)
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

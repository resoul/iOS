//
//  GridView.swift
//  iOS
//

import UIKit

class GridView: UIView {
    
    fileprivate let line1 = GridViewLine()
    fileprivate let line2 = GridViewLine()
    fileprivate let line3 = GridViewLine()
    fileprivate let line4 = GridViewLine()
    
    fileprivate let stroke: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(line1, line2, line3, line4)
        isUserInteractionEnabled = false
        
        let screenWidth = UIScreen.main.bounds.width
        let row1 = CGFloat(-screenWidth * 0.33)
        let row2 = CGFloat(-screenWidth * 0.66)
        line1.makeLayout(width: stroke, height: 0)
        line2.makeLayout(width: stroke, height: 0)
        line3.makeLayout(width: 0, height: stroke)
        line4.makeLayout(width: 0, height: stroke)
        
        line1.makeLayout(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: row1))
        line2.makeLayout(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: row2))
        line3.makeLayout(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: row1, right: 0))
        line4.makeLayout(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: row2, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

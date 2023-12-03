//
//  Zoomable.swift
//  iOS
//

import UIKit

class Zoomable: UIView {
    
    private var cropFitState: Bool = false
    
    private lazy var cropButton: UIButton = {
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "arrow.down.left.and.arrow.up.right", withConfiguration: imageConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)

        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .black.withAlphaComponent(0.3)
        btn.layer.cornerRadius = 32 / 2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(handleSquareCropping), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var zoomableAsset: ZoomableAsset = {
        let view = ZoomableAsset(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        view.zoomDelegate = self
        
        return view
    }()
    
    private lazy var gridLayout: GridLineLayout = {
        let view = GridLineLayout()
        view.alpha = 0
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(zoomableAsset, gridLayout, cropButton)
        zoomableAsset.fillSuperview()
        gridLayout.fillSuperview()
        cropButton.makeLayout(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 16, right: 0), size: .init(width: 32, height: 32))
    }
    
    @objc
    func handleSquareCropping() {
        cropFitState = cropFitState == true ? false : true
        setCropButtonImage(cropFitState: cropFitState)
        zoomableAsset.fit(cropFitState)
    }
    
    private func setCropButtonImage(cropFitState: Bool) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        var imageIcon = "arrow.down.left.and.arrow.up.right"
        if cropFitState {
            imageIcon = "arrow.up.right.and.arrow.down.left"
        }
        
        let image = UIImage(systemName: imageIcon, withConfiguration: imageConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        cropButton.setImage(image, for: .normal)
    }
    
    func setImage(_ photo: UIImage) {
        zoomableAsset.setImage(photo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Zoomable: ZoomableAssetDelegate {
    func layoutSubviews(_ view: ZoomableAsset) {
        let frame = zoomableAsset.assetImageView.convert(zoomableAsset.assetImageView.bounds, to: self)
        gridLayout.frame = self.frame.intersection(frame)
        gridLayout.layoutIfNeeded()
    }
    
    func cropButtonIsHidden(hidden: Bool) {
        cropButton.isHidden = hidden
    }
    
    func scrollViewDidZoom() {
        UIView.animate(withDuration: 0.1) {
            //self.gridLayout.alpha = 1
        }
    }
    
    func scrollViewDidEndZooming() {
        UIView.animate(withDuration: 0.3) {
            //self.gridLayout.alpha = 0
        }
    }
}

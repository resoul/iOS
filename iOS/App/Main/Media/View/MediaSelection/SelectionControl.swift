//
//  SelectionControl.swift
//  iOS
//

import UIKit

class SelectionControl: UIView {
    
    lazy var albumButton: UIButton = {
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        config.imagePadding = 5
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = imageConfig
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            
            return outgoing
        }
        let btn = UIButton(configuration: config)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Recent", for: .normal)
        
        return btn
    }()
    
    lazy var multipleButton: UIButton = {
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "square.3.layers.3d.down.backward", withConfiguration: imageConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)

        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 32 / 2
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    lazy var cameraButton: UIButton = {
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "camera", withConfiguration: imageConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)

        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 32 / 2
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(cameraButton, albumButton, multipleButton)
        setupConstraints()
    }
    
    func updateShevronState(down: Bool) {
        if down {
            albumButton.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        } else {
            albumButton.setImage(UIImage(systemName: "chevron.up")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        }
    }
    
    private func setupConstraints() {
        albumButton.makeLayout(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 6, right: 0), size: .init(width: 0, height: 32))
        cameraButton.makeLayout(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 16), size: .init(width: 32, height: 32))
        multipleButton.makeLayout(top: nil, leading: nil, bottom: bottomAnchor, trailing: cameraButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 16), size: .init(width: 32, height: 32))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

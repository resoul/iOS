//
//  AssetManager.swift
//  iOS
//

import UIKit
import Photos

class AssetManager {
    lazy var dataSource: AssetDataSource = AssetDataSource()
    
    private let imageStorage: PHCachingImageManager = PHCachingImageManager()
    
    func requestImage(asset: PHAsset, size: CGSize, completion: @escaping (UIImage) -> Void) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        imageStorage.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { image, _ in
            guard let image = image else {
                if let logo = UIImage(named: "logo") {
                    completion(logo)
                }
                return
            }
            completion(image)
        }
    }
}

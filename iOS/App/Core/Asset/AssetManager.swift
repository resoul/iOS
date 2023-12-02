//
//  AssetManager.swift
//  iOS
//

import UIKit
import Photos

class AssetManager {
    lazy var dataSource: AssetDataSource = AssetDataSource()
    
    private let cacheManager: PHCachingImageManager = PHCachingImageManager()
    
    private let imageManager = PHImageManager()
    
    func fetchImage(for asset: PHAsset, completion: @escaping(UIImage, Bool) -> Void) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.isNetworkAccessAllowed = true
        
        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
            guard let image = image else {
                print("Failed to fetch image.")
                return
            }
            
            DispatchQueue.main.async {
                let isDegrade = (info?[PHImageResultIsDegradedKey] as? Bool) ?? false
                completion(image, isDegrade)
            }
        }
    }
    
    func fetchCacheImage(asset: PHAsset, size: CGSize, completion: @escaping (UIImage) -> Void) {
        cacheManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions()) { image, _ in
            guard let image = image else {
                if let logo = UIImage(named: "logo") {
                    completion(logo)
                }
                return
            }
            completion(image)
        }
    }
    
    private func imageOptions() -> PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        return options
    }
}

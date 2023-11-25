//
//  AssetDataSource.swift
//  iOS
//

import Photos

class AssetDataSource {
    private(set) var items: [AssetCollection] = []
    private(set) var regular: AssetCollection?
    
    func fetchData(_ completion: (() -> ())?) {
        let collections = [
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil),
            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        ]
        for collection in collections {
            collection.enumerateObjects { assetCollection, _, _ in
                let assets = PHAsset.fetchAssets(in: assetCollection, options: self.fetchOptions())
                self.setAlbum(assetCollection: assetCollection, assets: assets)
                if assetCollection.assetCollectionType == .smartAlbum && assetCollection.assetCollectionSubtype == .smartAlbumUserLibrary {
                    self.setRegularAlbum(assetCollection: assetCollection, assets: assets)
                }
            }
        }
        completion?()
    }
    
    private func setAlbum(assetCollection: PHCollection, assets: PHFetchResult<PHAsset>) {
        self.items.append(AssetCollection(
            localIdentifier: assetCollection.localIdentifier,
            title: assetCollection.localizedTitle ?? "",
            assets: assets,
            count: assets.count,
            preview: assets.firstObject
        ))
    }
    
    private func setRegularAlbum(assetCollection: PHCollection, assets: PHFetchResult<PHAsset>) {
        self.regular = AssetCollection(
            localIdentifier: assetCollection.localIdentifier,
            title: assetCollection.localizedTitle ?? "",
            assets: assets,
            count: assets.count,
            preview: assets.firstObject
        )
    }
    
    private func fetchOptions() -> PHFetchOptions {
        let options = PHFetchOptions()
        options.predicate = NSPredicate(
            format: "mediaType = %d || mediaType = %d",
            PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue
        )
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return options
    }
}

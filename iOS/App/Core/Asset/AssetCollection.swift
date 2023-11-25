//
//  AssetCollection.swift
//  iOS
//

import Photos

struct AssetCollection {
    let localIdentifier: String
    let title: String
    let assets: PHFetchResult<PHAsset>
    let count: Int
    let preview: PHAsset?
}

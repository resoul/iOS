//
//  ZoomableAssetDelegate.swift
//  iOS
//

protocol ZoomableAssetDelegate: AnyObject {
    func cropButtonIsHidden(hidden: Bool)
    func layoutSubviews(_ view: ZoomableAsset)
    func scrollViewDidZoom()
    func scrollViewDidEndZooming()
}

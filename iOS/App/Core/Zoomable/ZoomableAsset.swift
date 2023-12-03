//
//  ZoomableAsset.swift
//  iOS
//

import UIKit

class ZoomableAsset: UIScrollView {
    
    weak var zoomDelegate: ZoomableAssetDelegate?
    
    var cropFitState: Bool = false
    
    var isVideo = false
    
    var assetImageView: UIImageView {
        return isVideo ? imageView : imageView
    }
    
    var squaredZoomScale: CGFloat = 1.0
    
    fileprivate lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        maximumZoomScale = 6.0
        minimumZoomScale = 1.0
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = true
        alwaysBounceHorizontal = true
        isScrollEnabled = true
        clipsToBounds = true
        delegate = self
    }
    
    func setImage(_ photo: UIImage) {
        if imageView.isDescendant(of: self) == false {
            addSubview(imageView)
        }
        imageView.image = photo
        setAssetFrame(for: imageView, image: photo)
    }
    
    func fit(_ fit: Bool, animated: Bool = false) {
        squaredZoomScale = calculateSquaredZoomScale()
        if fit {
            setZoomScale(squaredZoomScale, animated: animated)
        } else {
            setZoomScale(1.0, animated: animated)
        }
    }
    
    fileprivate func setAssetFrame(for view: UIView, image: UIImage) {
        // Reseting the previous scale
        self.minimumZoomScale = 1.0
        self.zoomScale = 1.0
        
        let screenWidth = UIScreen.main.bounds.width
        var aspectRatio: CGFloat = 1.0
        
        print("size", image.size)
        
        if image.size.height > image.size.width {
            // Portrait
            aspectRatio = image.size.width / image.size.height
            view.frame.size.width = screenWidth * aspectRatio
            view.frame.size.height = screenWidth
            zoomDelegate?.cropButtonIsHidden(hidden: false)
        } else if image.size.width > image.size.height {
            // Landscape
            aspectRatio = image.size.height / image.size.width
            view.frame.size.width = screenWidth
            view.frame.size.height = screenWidth * aspectRatio
            zoomDelegate?.cropButtonIsHidden(hidden: false)
        } else {
            // Square
            view.frame.size.width = screenWidth
            view.frame.size.height = screenWidth
            zoomDelegate?.cropButtonIsHidden(hidden: true)
        }
        
        view.center = self.center
    }
    
    fileprivate func calculateSquaredZoomScale() -> CGFloat {
        let squareZoomScale: CGFloat = 1.0
        guard let image = assetImageView.image else {
            return squareZoomScale
        }
        // Portrait
        if image.size.height > image.size.width {
            return (image.size.height / image.size.width)
        }
        
        // Landscape
        if image.size.width > image.size.height {
            return (image.size.width / image.size.height)
        }
        
        return squareZoomScale
    }
    
    @objc
    func handleSquareCropping() {
        cropFitState = cropFitState == true ? false : true
        fit(cropFitState)
    }
    
    func setAssetView() {
        let assetView = isVideo ? imageView : imageView
        let scrollViewBoundsSize = self.bounds.size
        var assetFrame = assetView.frame
        let assetSize = assetView.frame.size
        
        assetFrame.origin.x = (assetSize.width < scrollViewBoundsSize.width) ?
            (scrollViewBoundsSize.width - assetSize.width) / 2.0 : 0
        assetFrame.origin.y = (assetSize.height < scrollViewBoundsSize.height) ?
            (scrollViewBoundsSize.height - assetSize.height) / 2.0 : 0.0
        
        assetView.frame = assetFrame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        zoomDelegate?.layoutSubviews(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZoomableAsset: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return isVideo ? imageView : imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        zoomDelegate?.scrollViewDidZoom()
        setAssetView()
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        zoomDelegate?.scrollViewDidEndZooming()
    }
}

extension ZoomableAsset {
    var croppedImage: UIImage? {
        var rect = visibleRect()
        rect = rect.applying(rectTransform())
        
        guard let scale = imageView.image?.scale,
            let orientation = imageView.image?.imageOrientation,
            let ref = imageView.image?.cgImage?.cropping(to: rect) else {
            return nil
        }
        
        let image = UIImage(cgImage: ref, scale: scale, orientation: orientation)
        return image
    }
    
    private func visibleRect() -> CGRect {
        guard let imageWidth = imageView.image?.size.width,
              imageView.frame.size.width > 0 else {
            return .zero
        }
        
        let sizeScale = (imageWidth / imageView.frame.size.width) * zoomScale
        var rect = convert(bounds, to: imageView)
        rect.origin.x *= sizeScale
        rect.origin.y *= sizeScale
        rect.size.width *= sizeScale
        rect.size.height *= sizeScale

        return rect
    }
    
    private func rectTransform() -> CGAffineTransform {
        guard let image = imageView.image else {
            return CGAffineTransform.identity
        }
        let orientation = image.imageOrientation
        let scale = image.scale
        let width = image.size.width
        let height = image.size.height
        var transform = CGAffineTransform()
        
        switch orientation {
        case .left:
            transform = transform.rotated(by: radians(90)).translatedBy(x: 0, y: -height)
        case .right:
            transform = transform.rotated(by: radians(-90)).translatedBy(x: -width, y: 0)
        case .down:
            transform = transform.rotated(by: radians(-180)).translatedBy(x: -width, y: -height)
        default:
            transform = CGAffineTransform.identity
        }
        
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
    
    private func radians(_ degrees: Int) -> CGFloat {
        return CGFloat(CGFloat(degrees) * .pi / 180)
    }
}

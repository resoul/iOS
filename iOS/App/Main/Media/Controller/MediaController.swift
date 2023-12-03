//
//  MediaController.swift
//  iOS
//

import UIKit

class MediaController: UIViewController {
    
    private let manager = AssetManager()
    
    var selectedSection: Int = 0
    
    private lazy var mediaSelection: MediaSelection = {
        let view = MediaSelection()
        view.navigationHeight = navigationHeight()
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/4),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.5, leading: 0.5, bottom: 0.5, trailing: 0.5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/4)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(mediaSelection, collectionView)
        view.backgroundColor = .black
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: MediaCollectionViewCell.self)

        mediaSelection.makeLayout(top: view.topAnchor, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: calculateMediaSelectionHeight()))
        collectionView.makeLayout(top: mediaSelection.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: calculateCollectionViewHeight()))
        
        manager.dataSource.fetchData {
            DispatchQueue.main.async {
                self.mediaSelection.updateAlbumName(title: self.manager.dataSource.items[self.selectedSection].title)
                self.collectionView.reloadData()
                if self.manager.dataSource.items[self.selectedSection].count > 0 {
                    let selectItem = IndexPath(item: 0, section: self.selectedSection)
                    self.collectionView.selectItem(at: selectItem, animated: false, scrollPosition: .top)
                    self.collectionView(self.collectionView, didSelectItemAt: selectItem)
                }
            }
        }
    }
    
    private func navigationHeight() -> CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0
    }
    
    private func calculateMediaSelectionHeight() -> CGFloat {
        return UIApplication.shared.statusBarHeight + navigationHeight() + navigationHeight() + UIScreen.main.bounds.width
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        return UIScreen.main.bounds.height - calculateMediaSelectionHeight()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension MediaController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.dataSource.items[selectedSection].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MediaCollectionViewCell.self, for: indexPath)
        let asset = manager.dataSource.items[selectedSection].assets[indexPath.item]
        manager.fetchCacheImage(asset: asset, size: imageSize()) { image in
            DispatchQueue.main.async {
                cell.configure(thumb: image)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = manager.dataSource.items[selectedSection].assets[indexPath.item]
        manager.fetchImage(for: asset) { (image, isDegrade) in
            self.mediaSelection.setImage(image)
            print(isDegrade)
        }
    }
    
    private func imageSize() -> CGSize {
        let size = UIScreen.main.bounds.width / 4 * UIScreen.main.scale
        return CGSize(width: size, height: size)
    }
}

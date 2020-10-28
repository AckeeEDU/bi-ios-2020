//
//  SearchViewController.swift
//  FITstagram
//
//  Created by Jakub Olejník on 28.10.2020.
//

import UIKit

class SearchViewController: UIViewController {
    private weak var collectionView: UICollectionView!
    
    private var photos = [
        UIImage(named: "image")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
    ]
    private var registration: UICollectionView.CellRegistration<UICollectionViewCell, UIImage>!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        self.collectionView = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registration = UICollectionView.CellRegistration<UICollectionViewCell, UIImage> { cell, indexPath, item in
            cell.contentConfiguration = ImageConfiguration(image: item)
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 4 * 3)
        }
        
        let numberOfCols = CGFloat(3)
        let itemSize = floor(collectionView.frame.width / numberOfCols)
        
        /// Last column will be a bit wider on some devices, so we fill the whole screen
        if indexPath.item % Int(numberOfCols) == 0 {
            return CGSize(width: collectionView.frame.width - numberOfCols * itemSize + itemSize, height: itemSize)
        }
        
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: photos[indexPath.item])
    }
}

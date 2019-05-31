//
//  PhotosCollectionView.swift
//  Mobiquity
//
//  Created by B0206315 on 26/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation
import UIKit

protocol PhotosCollectionViewProtocol {
    func updateCollectionView(photosArray: [FlickerPhotoDetails])
}

class PhotosCollectionView: UIViewController, PhotosCollectionViewProtocol, UICollectionViewDelegateFlowLayout{
    fileprivate var photosArray:[FlickerPhotoDetails] = []
    fileprivate var photosPresenter: PhotosCollectionPresenterProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        photosPresenter = PhotosCollectionViewPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updateCollectionView(photosArray: [FlickerPhotoDetails]) {
        self.photosArray = photosArray;
        collectionView.reloadData()
    }
}

// Below Datasource can be moved out as a separate class and its instance will be injected in PhotosCollectionView class. Communication can be managed through delegates/closures.

extension PhotosCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        if let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as? PhotosCollectionViewCell{
            //Images can be cached using NSCache and reused instead of making them nil.
            photoCell.imageView.image = nil
            let photoString = photosPresenter?.createPhotoURL(flikerPhoto: photosArray[indexPath.row])
            photoCell.imageView.downloadImageFrom(link: photoString ?? "", contentMode: UIView.ContentMode.center)
            return photoCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}


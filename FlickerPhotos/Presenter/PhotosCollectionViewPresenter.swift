//
//  PhotosCollectionViewPresenter.swift
//  Mobiquity
//
//  Created by B0206315 on 28/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

protocol PhotosCollectionPresenterProtocol {
    func createPhotoURL(flikerPhoto: FlickerPhotoDetails) -> String
}
class PhotosCollectionViewPresenter:  NSObject, PhotosCollectionPresenterProtocol{
    
    override init() {
        super.init()
    }
    
    // Please refer to comments of UIImage+LazyLoading.swift file on how to optimize below code.
    func createPhotoURL(flikerPhoto: FlickerPhotoDetails) -> String {
        var photoUrlString = ""
        if let farm = flikerPhoto.farm, let server = flikerPhoto.server, let id = flikerPhoto.id, let secret = flikerPhoto.secret{
            photoUrlString = String.init(format: Constants.Photos.photoDetailBaseUrl,farm,server, id,secret)
        }
        return photoUrlString
        
    }
}

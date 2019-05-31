//
//  FlickerPhotosModel.swift
//  Mobiquity
//
//  Created by B0206315 on 27/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

struct FlickerPhotos :Codable{
    
    let photos: Photo?
}

struct Photo : Codable{
    let photo: [FlickerPhotoDetails]?
}

struct FlickerPhotoDetails: Codable{
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
}

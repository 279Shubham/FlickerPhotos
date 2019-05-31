//
//  AppConstants.swift
//  Mobiquity
//
//  Created by B0206315 on 26/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

struct Constants{
    struct Photos {
        static let photosListBaseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=afdaeacfa8ad7af13b4c059463e3f4a5&format=json&nojsoncallback=1&text=%@"
        static let photoDetailBaseUrl = "http://farm%d.static.flickr.com/%@/%@_%@.jpg"
    }
    
}

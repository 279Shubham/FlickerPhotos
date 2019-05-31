//
//  DataDownloaderMock.swift
//  MobiquityTests
//
//  Created by B0206315 on 30/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation
@testable import FlickerPhotos

class FlickerPhotosDownloaderMock: DownloadRequest {
    var downloadDataCalled = false
    
    func downloadData(url:URL, completion: @escaping (Data?)->()){
        downloadDataCalled = true;
        completion(getDataFromJson()!)
        
    }
    
    func getDataFromJson() -> Data? {
        var data :Data? = Data.init()
        if let path = Bundle(for: type(of: self )).url(forResource: "FlickerPhotosApiResponse", withExtension: "json"){  //(forResource: "FlickerPhotosApiResponse", ofType: "json") {
            data =  try? Data(contentsOf: path, options: .mappedIfSafe)
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return data
        }
        return data
    }

}

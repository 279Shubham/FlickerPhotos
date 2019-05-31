//
//  DataDownloader.swift
//  Mobiquity
//
//  Created by B0206315 on 28/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

enum HttpRequestType:String {
    case GET
    case POST
    case PUT
    
    //function can be used to return String value
}

protocol DownloadRequest: class{
    func downloadData(url:URL, completion: @escaping (Data?)->())
}

extension DownloadRequest {
    
    func downloadData(url: URL, completion: @escaping (Data?) -> ()) { // URLRequest can be passed as function argument which will further decrease the load of this function.
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10000
        urlRequest.httpMethod = HttpRequestType.GET.rawValue //function can be written in enum  return String value
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else{
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
        task.resume()
    }
}

//As complexity increases below code should be moved out of this file.
class FlickerPhotosDownloader: DownloadRequest {
    
}



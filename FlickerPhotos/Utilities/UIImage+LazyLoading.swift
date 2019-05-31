//
//  LazyImageDownloader.swift
//  Mobiquity
//
//  Created by B0206315 on 28/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        // For better performance, OperationQueue can be used, every image load can become one operation, qos can be given high for the cells which are visible while cells which are being recycled can be given low qos or can also be stopped from downloading altogether. Collection view delegate methods can be used for triggering the qos change.
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async{
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

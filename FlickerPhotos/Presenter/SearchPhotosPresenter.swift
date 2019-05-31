//
//  PhotosPresenter.swift
//  Mobiquity
//
//  Created by B0206315 on 26/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

protocol SearchViewPresenterProtocol{
    func downloadPhotos(key: String)
}

// 1. A base presenter and Base view can be written with init method init(view:BaseViewProtocol), which should save
// view in a weak reference
class SearchViewPresenter : NSObject,SearchViewPresenterProtocol{
    private weak var view: SearchViewProtocol? // 1.this should be moved to a base class (BasePresenter)
    
    var dataDownloader: DownloadRequest?
    var dataStorage: DataStoreProtocol?
    
    private var flickerPhotos: [FlickerPhotoDetails]? {
        didSet{
            if let photos = flickerPhotos{
                view?.updateView(data: photos)
            }
        }
    }
    required init(view: SearchViewProtocol){ // 1.this should be moved to BasePresenter
        super.init()
        self.view = view
        dataDownloader = FlickerPhotosDownloader();
        dataStorage = UserDefalutsDataStore.shared()
    }
    
    private func storeToUserDefaults(key:String) {
        guard var historyArray = dataStorage?.retrieve(key: "history") as? [String] else{
            dataStorage?.store(data: [key.lowercased()], forKey: "history")
            return
        }
        historyArray = historyArray.filter({$0 != key.lowercased()})
        historyArray.insert(key.lowercased(), at: 0)
        dataStorage?.store(data: historyArray, forKey: "history")
    }
    
    func downloadPhotos(key: String) {
        let photosUrlString =  String(format: Constants.Photos.photosListBaseUrl, key)
        guard let url = URL.init(string: photosUrlString) else {
            return
        }
        dataDownloader?.downloadData(url: url) {[weak self] (data) in
            if let data = data{
                do {
                    guard let photos  = try? JSONDecoder().decode(FlickerPhotos.self, from: data).photos,let  photoDetails = photos?.photo  else{
                        return
                    }
                    self?.flickerPhotos = photoDetails
                    self?.storeToUserDefaults(key: key)
                }
            }
        }
    }
    
}


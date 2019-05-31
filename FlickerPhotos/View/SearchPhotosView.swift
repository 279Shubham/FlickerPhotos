//
//  ViewController.swift
//  Mobiquity
//
//  Created by B0206315 on 26/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import UIKit

protocol SearchViewProtocol :class{
    func updateView(data:[FlickerPhotoDetails])
}

class SearchViewController: UIViewController {
    
    var searchPresenter: SearchViewPresenterProtocol?

    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var photosCollectionView: PhotosCollectionViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchPresenter = SearchViewPresenter.init(view: self)
        navigationItem.title = "Search Photos"
    }
    
    @IBAction func histroyButtonTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoCollectionVC"{
            let vc = segue.destination as? PhotosCollectionView
            photosCollectionView = vc
        }
        if segue.identifier == "showHistoryTable"{
            let vc = segue.destination as? HistoryTableView
            vc?.selectedCompletionHandler = {[weak self] (selected:String) in
                self?.searchPresenter?.downloadPhotos(key: selected)
            }
        }
    }
}

// As complexity increases below code can be moved in a separate class to acieve SRP, communication can be done via protocols(delegate pattern) or closure callbacks.

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPresenter?.downloadPhotos(key: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController:SearchViewProtocol{
    func updateView(data: [FlickerPhotoDetails]) {
        photosCollectionView?.updateCollectionView(photosArray: data)
    }
}

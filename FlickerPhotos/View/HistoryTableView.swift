//
//  HistoryTableView.swift
//  Mobiquity
//
//  Created by B0206315 on 30/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableView: UITableViewController {
    
    var selectedCompletionHandler:((String)->())?
    var historySearch:[String] = []
    var dataStorage: DataStoreProtocol = UserDefalutsDataStore.shared()
    
    override func viewDidLoad() {
        if let savedSearch = dataStorage.retrieve(key: "history") as? [String]{
            historySearch = savedSearch
        }
        navigationItem.title = "Search History"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historySearch.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
            photoCell.textLabel?.text = historySearch[indexPath.row]
        return photoCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selected = selectedCompletionHandler{
            selected(historySearch[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
}

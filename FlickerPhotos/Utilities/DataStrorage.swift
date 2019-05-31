//
//  DataStroreUtility.swift
//  Mobiquity
//
//  Created by B0206315 on 29/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    func store(data:Any , forKey key: String)
    func retrieve(key: String) -> Any?
}

/*
 1. Currently User Defaults is used to store data locally, protocol is used to make dependecy injection/mocking possible for unit testing
 2. This protocol if implemented with associatedType, can be implemeted by different classes to store data in different storages(userdefaults/plist/sqlite/coredata). This Protocol will facilitate us to write an adapter.
 3. Factory design pattern can be used to create concrete classes of DataSourceProtocol.
 */

class UserDefalutsDataStore: DataStoreProtocol {
   
    private init() {
        
    }
    
    public class func shared () -> UserDefalutsDataStore{
        return UserDefalutsDataStore.init()
    }
    
    //typealias value = T
    let userDefaults = UserDefaults.standard
    
    func store(data: Any, forKey key: String) {
        userDefaults.set(data , forKey: key)
    }
    
    func retrieve(key: String) -> Any? {
         return userDefaults.value(forKey: key) 
    }
}

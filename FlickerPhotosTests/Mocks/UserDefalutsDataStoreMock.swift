//
//  File.swift
//  MobiquityTests
//
//  Created by B0206315 on 30/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import Foundation

@testable import FlickerPhotos

class UserDefalutsDataStoreMock: DataStoreProtocol {
    
    private var storage:[String : Any] = [:]
    
    private init(){
        
    }
    
    class public func shared() -> UserDefalutsDataStoreMock{
        return UserDefalutsDataStoreMock.init()
    }
    
    func store(data: Any, forKey key: String) {
        storage[key] = data
    }
    
    func retrieve(key: String) -> Any? {
        return storage[key]
    }

    func deleteAllData() {
        storage = [:]
    }
}

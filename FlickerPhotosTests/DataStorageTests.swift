//
//  DataStorageTests.swift
//  MobiquityTests
//
//  Created by B0206315 on 29/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import XCTest

@testable import FlickerPhotos
class DataStorageTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        resetDefaults()
    }

    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

    func testStringStorageAndRetrievalWhenDataIsStoredForParticularKey() {
        let sut = UserDefalutsDataStore.shared()
            //UserDefalutsDataStore<String>.init()
        sut.store(data: "testString", forKey: "testKey")
        XCTAssert(sut.retrieve(key: "testKey") as! String == "testString", "Data Storage in UserDefaults Failed")
    }

    func testStringStorageAndRetrievalWhenDataIsNotStoredForParticularKey() {
        let sut = UserDefalutsDataStore.shared()
        XCTAssertNil(sut.retrieve(key: "testKey"), "Data is getting returned even when no data is stored in User Defaults")
    }
    
    func testBoolStorageAndRetrievalWhenDataIsStoreForParticularKey() {
        let sut = UserDefalutsDataStore.shared()
        sut.store(data: true, forKey: "testKey")
        XCTAssert(sut.retrieve(key: "testKey") as! Bool, "Data Storage in UserDefaults Failed for Bool type")
    }
    
    func testDictionaryStorageWhenDataIsStoredForPrticularKey() {
        let sut = UserDefalutsDataStore.shared()
        sut.store(data: ["test" : "test"], forKey: "testKey")
        
        XCTAssert((sut.retrieve(key: "testKey")as! [String:String])["test"] == "test", "Data Storage in UserDefaults Failed for Dictionary type")
    }
}

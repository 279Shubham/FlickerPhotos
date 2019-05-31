//
//  PhotosPresenterTests.swift
//  MobiquityTests
//
//  Created by B0206315 on 26/05/19.
//  Copyright © 2019 Mobiquity. All rights reserved.
//

import XCTest
@testable import FlickerPhotos

class SearchViewMock: SearchViewProtocol {
    var data : Any? // this type be kept to Any so that this variable can be used to store miltiple functions response
    
    func updateView(data: [FlickerPhotoDetails]) {
        self.data = data
    }
}


class SearchViewPresenterTests: XCTestCase {
    var sut:SearchViewPresenter!
    
    var mockSearchView: SearchViewMock!
    var userDefaultsMock = UserDefalutsDataStoreMock.shared()
    var dataDownloaderMock: FlickerPhotosDownloaderMock!
    override func setUp() {
        mockSearchView = SearchViewMock.init()
        //Inject dependencies
        sut = SearchViewPresenter.init(view: mockSearchView)
        sut.dataStorage = userDefaultsMock
        dataDownloaderMock = FlickerPhotosDownloaderMock.init()
        sut.dataDownloader = dataDownloaderMock
    }

    override func tearDown() {
        userDefaultsMock.deleteAllData()
        mockSearchView = nil
        dataDownloaderMock = nil
    }

    func testWhenValidDataIsReturnedByApiThenUpdateViewIsCslled() {
        sut.downloadPhotos(key: "anyKey")
        XCTAssertTrue(mockSearchView.data != nil)
    }

    func testWhenValidDataIsReturnedByApiThenDataIsRightlyParsed() {
        sut.downloadPhotos(key: "anyKey")
        let flickerPhotosDetails = mockSearchView.data as! [FlickerPhotoDetails]
        XCTAssertEqual(flickerPhotosDetails.count, 2, "Data parsing returned wrong numbe of items in array")
        
        /* I prefer nested functions to write multiple tests for functionality which fall uner same context
         e.g. here we test for positive case of API response, which stores the search item in history
         so that can be nested inside this test. Howeverthe failure message becomes very important to understand the problem area from failing tests
        */
        func testKeyIsStoredInUserDefaults(){
            let storedHistroy = sut.dataStorage?.retrieve(key: "history") as! [String]
            XCTAssertEqual(storedHistroy[0], "anykey", "search item is not stored in history")
        }
        testKeyIsStoredInUserDefaults()

    }
    
    func testSearchHistoryIsStoredWhenPhotoSearchIsPerformed() {
        sut.downloadPhotos(key: "key1")
        sut.downloadPhotos(key: "key2")
        let storedHistroy = sut.dataStorage?.retrieve(key: "history") as! [String]
        XCTAssertEqual(storedHistroy, ["key2","key1"], "search items history order is broken")
        
        func testWhenSameSearchIsPerformedAgainTheOrderOfHistoryItemsIsRight(){
            sut.downloadPhotos(key: "key3")
            sut.downloadPhotos(key: "key4")
            sut.downloadPhotos(key: "key1")
            let storedHistroy = sut.dataStorage?.retrieve(key: "history") as! [String]
            XCTAssertEqual(storedHistroy, ["key1","key4","key3","key2"], "search items history does not work when already searched item is searched again")
        }
        
        testWhenSameSearchIsPerformedAgainTheOrderOfHistoryItemsIsRight()
    }
    
}

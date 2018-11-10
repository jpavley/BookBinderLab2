//
//  JsonModelTests.swift
//  BookBinderLab2Tests
//
//  Created by John Pavley on 11/9/18.
//  Copyright © 2018 John Pavley. All rights reserved.
//

import XCTest

class JsonModelTests: XCTestCase {
    var testWork1: JsonModel.JsonVolume.JsonWork!
    var testWork2: JsonModel.JsonVolume.JsonWork!
    var testWork3: JsonModel.JsonVolume.JsonWork!
    
    var testVolume1: JsonModel.JsonVolume!
    var testVolume2: JsonModel.JsonVolume!
    var testVolume3: JsonModel.JsonVolume!

    var testModel: JsonModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testWork1 = JsonModel.JsonVolume.JsonWork(issueNumber: 1, variantLetter: "a", coverImage: "x", isOwned: true)
        testWork2 = JsonModel.JsonVolume.JsonWork(issueNumber: 2, variantLetter: "b", coverImage: "y", isOwned: false)
        testWork3 = JsonModel.JsonVolume.JsonWork(issueNumber: 3, variantLetter: "c", coverImage: "z", isOwned: true)

        testVolume1 = JsonModel.JsonVolume(publisherName: "a", seriesName: "x", era: 1, volumeNumber: 4, firstWorkNumber: 1, currentWorkNumber: 5, kind: "series", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)
        
        testVolume2 = JsonModel.JsonVolume(publisherName: "b", seriesName: "y", era: 2, volumeNumber: 5, firstWorkNumber: 1, currentWorkNumber: 10, kind: "one-shot", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)
        
        testVolume3 = JsonModel.JsonVolume(publisherName: "c", seriesName: "z", era: 3, volumeNumber: 6, firstWorkNumber: 1, currentWorkNumber: 15, kind: "annual", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)

        
        testModel = JsonModel(volumes: [testVolume1, testVolume2, testVolume3], selectedVolumeIndex: 0)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitFromPropterties() {
        
        XCTAssertNotNil(testWork1)
        XCTAssertNotNil(testWork2)
        XCTAssertNotNil(testWork3)
        
        XCTAssertNotNil(testVolume1)
        XCTAssertNotNil(testVolume2)
        XCTAssertNotNil(testVolume3)
        
        XCTAssertNotNil(testModel)
        
        XCTAssertEqual(testModel.volumes.count, 3)
        XCTAssertEqual(testModel.selectedVolumeIndex, 0)
        
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].volumeNumber, 4)
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].era, 1)
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].publisherName, "a")
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].works.count, 3)
        
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].works[testModel.volumes[testModel.selectedVolumeIndex].selectedWorkIndex].issueNumber, 1)
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].works[testModel.volumes[testModel.selectedVolumeIndex].selectedWorkIndex].variantLetter, "a")
        XCTAssertEqual(testModel.volumes[testModel.selectedVolumeIndex].works[testModel.volumes[testModel.selectedVolumeIndex].selectedWorkIndex].isOwned, true)
    }
    
    func testSelectionShortCuts() {
        XCTAssertEqual(testModel.selectedVolume.volumeNumber, 4)
        XCTAssertEqual(testModel.selectedVolume.era, 1)
        XCTAssertEqual(testModel.selectedVolume.publisherName, "a")
        XCTAssertEqual(testModel.selectedVolume.works.count, 3)
        
        XCTAssertEqual(testModel.selectedWork.issueNumber, 1)
        XCTAssertEqual(testModel.selectedWork.variantLetter, "a")
        XCTAssertEqual(testModel.selectedWork.isOwned, true)
    }
}

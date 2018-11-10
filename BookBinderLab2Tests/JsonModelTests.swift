//
//  JsonModelTests.swift
//  BookBinderLab2Tests
//
//  Created by John Pavley on 11/9/18.
//  Copyright © 2018 John Pavley. All rights reserved.
//

import XCTest

class JsonModelTests: XCTestCase {
    
    // proptery based
    
    var testWork1: JsonModel.JsonVolume.JsonWork!
    var testWork2: JsonModel.JsonVolume.JsonWork!
    var testWork3: JsonModel.JsonVolume.JsonWork!
    
    var testVolume1: JsonModel.JsonVolume!
    var testVolume2: JsonModel.JsonVolume!
    var testVolume3: JsonModel.JsonVolume!

    var testModel1: JsonModel!
    
    // bundle based
    
    var testModel2: JsonModel!
    
    private func initFromProperties() {
        testWork1 = JsonModel.JsonVolume.JsonWork(issueNumber: 1, variantLetter: "a", coverImage: "x", isOwned: true)
        testWork2 = JsonModel.JsonVolume.JsonWork(issueNumber: 2, variantLetter: "b", coverImage: "y", isOwned: false)
        testWork3 = JsonModel.JsonVolume.JsonWork(issueNumber: 3, variantLetter: "c", coverImage: "z", isOwned: true)
        
        testVolume1 = JsonModel.JsonVolume(publisherName: "a", seriesName: "x", era: 1, volumeNumber: 4, firstWorkNumber: 1, currentWorkNumber: 5, kind: "series", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)
        
        testVolume2 = JsonModel.JsonVolume(publisherName: "b", seriesName: "y", era: 2, volumeNumber: 5, firstWorkNumber: 1, currentWorkNumber: 10, kind: "one-shot", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)
        
        testVolume3 = JsonModel.JsonVolume(publisherName: "c", seriesName: "z", era: 3, volumeNumber: 6, firstWorkNumber: 1, currentWorkNumber: 15, kind: "annual", works: [testWork1, testWork2, testWork3], selectedWorkIndex: 0)
        
        
        testModel1 = JsonModel(volumes: [testVolume1, testVolume2, testVolume3], selectedVolumeIndex: 0)
    }
    
    private func initFromBundle() {
        if let path = Bundle.main.path(forResource: "sample1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                XCTAssertNotNil(data)
                
                do {
                    let decoder = JSONDecoder()
                    testModel2 = try decoder.decode(JsonModel.self, from: data)
                    
                    // succeeded -> data loaded and decoded!
                } catch {
                    // failed -> can't decode!
                    XCTAssertNil(error)
                    print(error)
                }
                
            } catch {
                // failed -> can't load data!
                XCTAssertNil(error)
                print(error)
            }
        }
    }


    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        initFromProperties()
        initFromBundle()
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
        
        XCTAssertNotNil(testModel1)
        
        XCTAssertEqual(testModel1.volumes.count, 3)
        XCTAssertEqual(testModel1.selectedVolumeIndex, 0)
        
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].volumeNumber, 4)
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].era, 1)
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].publisherName, "a")
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].works.count, 3)
        
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].works[testModel1.volumes[testModel1.selectedVolumeIndex].selectedWorkIndex].issueNumber, 1)
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].works[testModel1.volumes[testModel1.selectedVolumeIndex].selectedWorkIndex].variantLetter, "a")
        XCTAssertEqual(testModel1.volumes[testModel1.selectedVolumeIndex].works[testModel1.volumes[testModel1.selectedVolumeIndex].selectedWorkIndex].isOwned, true)
    }
    
    func testInitFromBundle() {
        XCTAssertNotNil(testModel2)
        
        XCTAssertEqual(testModel2.selectedVolume.publisherName, "Marble Entertainment")
        XCTAssertEqual(testModel2.selectedWork.issueNumber, 1)
        
        testModel2.selectedVolumeIndex = 3
        XCTAssertEqual(testModel2.selectedVolume.publisherName, "EKK Comics")
        XCTAssertEqual(testModel2.selectedWork.isOwned, true)
        
        testModel2.selectedVolume.selectedWorkIndex = 1
        XCTAssertEqual(testModel2.selectedWork.variantLetter, "a")
        
        testModel2.selectedVolumeIndex = 5
        XCTAssertEqual(testModel2.selectedVolume.seriesName, "Darling Dog")
        XCTAssertEqual(testModel2.selectedVolume.era, 1952)
        XCTAssertEqual(testModel2.selectedVolume.volumeNumber, 2)
        XCTAssertEqual(testModel2.selectedVolume.firstWorkNumber, 7)
        XCTAssertEqual(testModel2.selectedVolume.kind, "annual")
        XCTAssertEqual(testModel2.selectedVolume.selectedWorkIndex, 0)
        
        let issueList = [9, 11]
        let variantList = ["", "a"]
        let imageList = ["", "dd_v2_11_a"]
        let ownList = [true, false]
        
        for i in 0..<testModel2.selectedVolume.works.count {
            testModel2.selectedVolume.selectedWorkIndex = i
            
            XCTAssertEqual(testModel2.selectedWork.issueNumber, issueList[i])
            XCTAssertEqual(testModel2.selectedWork.variantLetter, variantList[i])
            XCTAssertEqual(testModel2.selectedWork.coverImage, imageList[i])
            XCTAssertEqual(testModel2.selectedWork.isOwned, ownList[i])
        }

    }
    
    func testSelectionShortCutsPropertyInit() {
        XCTAssertEqual(testModel1.selectedVolume.volumeNumber, 4)
        XCTAssertEqual(testModel1.selectedVolume.era, 1)
        XCTAssertEqual(testModel1.selectedVolume.publisherName, "a")
        XCTAssertEqual(testModel1.selectedVolume.works.count, 3)
        
        XCTAssertEqual(testModel1.selectedWork.issueNumber, 1)
        XCTAssertEqual(testModel1.selectedWork.variantLetter, "a")
        XCTAssertEqual(testModel1.selectedWork.isOwned, true)
    }
}

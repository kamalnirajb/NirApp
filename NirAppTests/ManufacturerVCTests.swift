//
//  ManufacturerVCTests.swift
//  NirApp
//
//  Created by Niraj Kumar on 3/1/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit
import XCTest
@testable import NirApp

class ManufacturerVCTests: XCTestCase {

    var vc:ManufacturerVC?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManufacturerVC") as! ManufacturerVC)
        self.vc?.performSelector(onMainThread: #selector(self.vc?.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    ///Mark: Test cases
    func testManufacturerViewLoaded() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(self.vc?.view, "View not loaded")
    }
    
    func testIfTableViewExists() {
        XCTAssertNotNil(self.vc?.tblviewManufacturers, "TableView not yet added")
    }
    
    func testManufacturerListLoaded() {
        XCTAssertNotEqual(ManufacturerOperation.sharedInstance.manufacturerList.count, 0, "Manufacturer list is not available yet")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
}

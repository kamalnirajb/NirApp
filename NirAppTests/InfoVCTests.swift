//
//  InfoVCTests.swift
//  NirApp
//
//  Created by Niraj Kumar on 3/1/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit
import XCTest
@testable import NirApp

class InfoVCTests: XCTestCase {
    var vc:InfoVC?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoVC") as! InfoVC)
        self.vc?.performSelector(onMainThread: #selector(self.vc?.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    ///Mark: Test cases
    func testInfoViewLoded() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(self.vc?.view, "View not loaded")
    }
    
    func testDataAvailable() {
        XCTAssertNotNil(self.vc?.manufacturer, "Manufacturer information is not available")
        XCTAssertNotNil(self.vc?.model, "Model information is not available")
    }
}

//
//  SampleTakeAwayTests.swift
//  SampleTakeAwayTests
//
//  Created by Adil Anwer on 9/28/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import XCTest
@testable import SampleTakeAway

class SampleTakeAwayTests: XCTestCase {

    var viewController: RestaurantListingVC?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "RestaurantListingVC") as? RestaurantListingVC
        viewController?.beginAppearanceTransition(true, animated: false)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
        //        viewController.endAppearanceTransition()
        //        viewController = nil
    }
    
    //Check Restaurant list table not be nil and its IBOutlet is connected
    func testRestaurantListingTable() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertNotNil(viewController?.restaurantsTbl, "table view should not be nil please check if its outlet connected")
        
    }
    
    //Check Restaurant list table cell not nil
    func testRestaurantTableCellNotNil() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let cell = viewController?.restaurantsTbl?.dequeueReusableCell(withIdentifier: CellIds.RestaurantCellId.rawValue)
        
        XCTAssertNotNil(cell, "table view should be able to deque cell with id \(CellIds.RestaurantCellId.rawValue)")
        
    }
    
    //Restaurant api call performance test
    func testPerformanceExample() {
        
        let manager = RestaurantApiManager()
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let requestParam = manager.getRestaurantApiParams()
            //Restaurant api call
            manager.api(requestParam, completion: {
                
                if manager.isSuccess {
                    
                    DispatchQueue.main.async {
                        
                        
                    }
                }
            })
        }
    }

}

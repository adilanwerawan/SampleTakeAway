//
//  DatabaseAndMoreFunctionalityTest.swift
//  SampleTakeAwayTests
//
//  Created by Adil Anwer on 9/29/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import UIKit
import XCTest
@testable import SampleTakeAway

class DatabaseAndMoreFunctionalityTests: XCTestCase {
    
    var viewController: RestaurantListingVC?
    // MARK: - Variables
    let manager = RestaurantApiManager()
    let dbOperationsManager = RestaurantDBModelOperations()
    
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
    
    //Check record is saving to Database
    func testRestaurantTableCellNotNil() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let requestParam = self.manager.getRestaurantApiParams()
        
        //Inside the api funtion records(restaurants) are saving to database
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                
                DispatchQueue.main.async {
                    
                    //Checking if api parse correctly
                    if let restaurants = self.manager.restaurantResponce{
                        
                        XCTAssertNotNil(restaurants, "should not be nil")
                        XCTAssertGreaterThan((restaurants.restaurants?.count ?? 0), 0, "should have restaurants")
                        
                        //Checking if records has been saved in db
                        let dbRestaurantsRecords = self.manager.restaurantDBOperations.getAllRestaurants()
                        XCTAssertNotNil(dbRestaurantsRecords, "should not be nil")
                        XCTAssertGreaterThan(dbRestaurantsRecords.count, 0, "should have restaurants")
                        
                    } else {
                        XCTFail()
                    }
                }
            }
        })
    }
    
    //Database functions performance test
    func testPerformanceExample() {
        
        let manager = RestaurantApiManager()
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let requestParam = manager.getRestaurantApiParams()
            //Inside the api funtion records are saving in database
            manager.api(requestParam, completion: {
                
                if manager.isSuccess {
                    
                    DispatchQueue.main.async {
                        
                        //Checking records get funtion performance
                        let dbRestaurantsRecords = self.manager.restaurantDBOperations.getAllRestaurants()
                        XCTAssertNotNil(dbRestaurantsRecords, "should not be nil")
                        XCTAssertGreaterThan(dbRestaurantsRecords.count, 0, "should have restaurants")
                    }
                }
            })
        }
    }

}

//
//  RestaurantApiManager.swift
//  SampleTakeAway
//
//  Created by Adil Anwer on 9/28/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import Foundation
import Alamofire

class RestaurantApiManager: AFManagerProtocol {
    
    var isSuccess   = false
    var restaurantResponce: Restaurant?
    let restaurantDBOperations = RestaurantDBModelOperations()
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        self.isSuccess = false
        
        //Request
        AFWrapper.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            if let responceDictnry = response as? Dictionary<String,Any> {
                //Come in this block when some logical error occur in api
                self.isSuccess = false
                if (responceDictnry["error"] != nil) {
                    
                    DispatchQueue.main.async {
                        
                        let message = responceDictnry["error_description"] ?? "Error in api"
                        Alert.showMsg(msg: message as! String)
                        
                    }
                } else if let errorMsg = responceDictnry["message"] {
                    
                    Alert.showMsg(msg: errorMsg as! String)
                }
            } else {
                
                guard let data = response as? Data else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Restaurant.self, from: data)
                    
                    self.isSuccess = true
                    self.restaurantResponce = model
                    
                    for restaurant in self.restaurantResponce?.restaurants ?? []{
                        
                        self.restaurantDBOperations.insert(restaurant)
                    }
                    
                } catch let err {
                    print("Err", err)
                }
            }
            
            completion()
        }) { (_) in
            
            completion()
        }
    }
}

//Mark : - Extension of restaurant manager to create parameters
extension RestaurantApiManager {
    
    //Function to create parameters
    func getRestaurantApiParams() -> AFParam {
        
        let headers: [String: String]? = [:]
        let parameters = [:] as [String: AnyObject]
        
        let endPoint = ""
        
        let param = AFParam(endpoint: endPoint, params: parameters, headers: headers!, method: .get, parameterEncoding: URLEncoding(destination: .methodDependent), images: [])
        return param
    }
}

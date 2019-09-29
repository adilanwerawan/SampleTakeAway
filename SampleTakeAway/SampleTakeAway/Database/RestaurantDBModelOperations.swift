//
//  RestaurantDBModelOperations.swift
//  SampleTakeAway
//
//  Created by Adil Anwer on 9/28/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RestaurantDBModelOperations{
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    func insert(_ restaurant: Restaurant)
    {
        
        let context = self.appdelegate.persistentContainer.viewContext
        let restaurantsArray = self.getAllRestaurants()
        var restaurantFound = false
        if restaurantsArray.count > 0{
            
            for  resto in restaurantsArray{
                
                if resto.restaurantName == restaurant.name{
                    
                    restaurantFound = true
                }
            }
        }
        
        if restaurantFound == false{
            
            let restuarantDBModel = NSEntityDescription.insertNewObject(forEntityName: "RestaurantDBModel", into: context) as! RestaurantDBModel
            restuarantDBModel.restaurantName = restaurant.name
            restuarantDBModel.status = restaurant.status
            restuarantDBModel.averageProductPrice = Int64(restaurant.sortingValues?.averageProductPrice ?? 0)
            restuarantDBModel.bestMatch = Double(restaurant.sortingValues?.bestMatch ?? 0.0)
            restuarantDBModel.deliveryCosts = Int64(restaurant.sortingValues?.deliveryCosts ?? 0)
            restuarantDBModel.distance = Int64(restaurant.sortingValues?.distance ?? 0)
            restuarantDBModel.isFavorite = false
            restuarantDBModel.minCost = Int64(restaurant.sortingValues?.minCost ?? 0)
            restuarantDBModel.newest = Double(restaurant.sortingValues?.newest ?? 0.0)
            restuarantDBModel.popularity = Double(restaurant.sortingValues?.popularity ?? 0.0)
            restuarantDBModel.ratingAverage = Double(restaurant.sortingValues?.ratingAverage ?? 0.0)
            
            do
            {
                try context.save()
            }
            catch
            {
                
            }
        }
    }
    
    func getAllRestaurants(_ sortBy:String) -> [RestaurantDBModel] {
        
        let context = self.appdelegate.persistentContainer.viewContext
        var restaurants  = [RestaurantDBModel]() // Where Locations = your NSManaged Class
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantDBModel")
        
        do {
            restaurants = try context.fetch(fetchRequest) as! [RestaurantDBModel]
            
            restaurants.sort {
                
                switch ($0.status, $1.status) {
                // True conditions
                case ("open", "order ahead"):return true
                case ("order ahead", "closed"): return true
                case ("open", "closed"): return true
                // False conditions
                case ("open", "open"): return false
                case ("order ahead", "order ahead"): return false
                case ("closed", "closed"): return false
                case ("closed", "open"): return false
                case ("closed", "order ahead"): return false
                case ("order ahead", "open"): return false
                    
                case (_, _):
                    
                    return false
                }
            }
            
            restaurants.sort{ $0.isFavorite && !$1.isFavorite }
            
            switch sortBy {
            case "newest":
                restaurants.sort{ $0.newest > $1.newest }
                break
            case "bestMatch":
                restaurants.sort{ $0.bestMatch > $1.bestMatch }
                break
            case "ratingAverage":
                restaurants.sort{ $0.ratingAverage > $1.ratingAverage }
                break
            case "distance":
                restaurants.sort{ $0.distance > $1.distance }
                break
            case "popularity":
                restaurants.sort{ $0.popularity > $1.popularity }
                break
            case "averageProductPrice":
                restaurants.sort{ $0.averageProductPrice > $1.averageProductPrice }
                break
            case "deliveryCosts":
                restaurants.sort{ $0.deliveryCosts > $1.deliveryCosts }
                break
            case "minCost":
                restaurants.sort{ $0.minCost > $1.minCost }
                break
            default:
                restaurants.sort{ $0.isFavorite && !$1.isFavorite }
                break
            }
            
            
        } catch {
            
            print("Failed")
        }
        
        return restaurants
    }
    
    func getAllRestaurants() -> [RestaurantDBModel] {
        
        let context = self.appdelegate.persistentContainer.viewContext
        var restaurants  = [RestaurantDBModel]() // Where Locations = your NSManaged Class
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantDBModel")
        
        do {
            restaurants = try context.fetch(fetchRequest) as! [RestaurantDBModel]
            
            restaurants.sort {
                
                switch ($0.status, $1.status) {
                // True conditions
                case ("open", "order ahead"):return true
                case ("order ahead", "closed"): return true
                case ("open", "closed"): return true
                // False conditions
                case ("open", "open"): return false
                case ("order ahead", "order ahead"): return false
                case ("closed", "closed"): return false
                case ("closed", "open"): return false
                case ("closed", "order ahead"): return false
                case ("order ahead", "open"): return false
                    
                case (_, _):
                    
                    return false
                }
            }
            
            restaurants.sort{ $0.isFavorite && !$1.isFavorite }
            
        } catch {
            
            print("Failed")
        }
        
        return restaurants
    }
    
    func update(_ isFavorite: Bool, restaurant:RestaurantDBModel?)
    {
        let context = self.appdelegate.persistentContainer.viewContext
        
        do {
            restaurant?.isFavorite = isFavorite
            try context.save()
        } catch  {
        }
    }
}

//
//  RestaurantCell.swift
//  SampleTakeAway
//
//  Created by Adil Anwer on 9/28/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var restaurantNameLbl: UILabel?
    @IBOutlet weak var statusLbl: UILabel?
    @IBOutlet weak var ratingView: CosmosView?
    @IBOutlet weak var sortLbl: UILabel?
    @IBOutlet weak var favBtn: UIButton?
    
    // MARK: - Variables
    var restaurant:RestaurantDBModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(restaurant: RestaurantDBModel?, sortBy:String) {
        
        if restaurant != nil {
            
            self.restaurant = restaurant
            self.restaurantNameLbl?.text = restaurant?.restaurantName ?? ""
            self.statusLbl?.text = restaurant?.status ?? ""
            self.ratingView?.rating = Double(restaurant?.ratingAverage ?? 0.0)
            if self.restaurant?.isFavorite == true{
                
                self.favBtn?.setImage(UIImage.init(named: "favoriteFilled"), for: .normal)
            } else{
                
                self.favBtn?.setImage(UIImage.init(named: "favoriteUnfilled"), for: .normal)
            }
            
            switch sortBy {
            case "newest":
                self.sortLbl?.text = "Newest: " + String(restaurant?.newest ?? 0.0)
                break
            case "bestMatch":
                self.sortLbl?.text = "BestMatch: " + String(restaurant?.bestMatch ?? 0.0)
                break
            case "ratingAverage":
                self.sortLbl?.text = "Rating: " + String(restaurant?.ratingAverage ?? 0.0)
                break
            case "distance":
                self.sortLbl?.text = "Distance: " + String(restaurant?.distance ?? 0)
                break
            case "popularity":
                self.sortLbl?.text = "Popularity: " + String(restaurant?.popularity ?? 0.0)
                break
            case "averageProductPrice":
                self.sortLbl?.text = "AveragePrice: " + String(restaurant?.averageProductPrice ?? 0)
                break
            case "deliveryCosts":
                self.sortLbl?.text = "DeliveryCost: " + String(restaurant?.deliveryCosts ?? 0)
                break
            case "minCost":
                self.sortLbl?.text = "MinCost: " + String(restaurant?.minCost ?? 0)
                break
            default:
                self.sortLbl?.text = sortBy
                break
            }
            
        }
    }
    
    @IBAction func favBtnPressed(_ sender: Any) {
        
        if self.restaurant?.isFavorite == true{
            
            self.favBtn?.setImage(UIImage.init(named: "favoriteUnfilled"), for: .normal)
        } else{
            
            self.favBtn?.setImage(UIImage.init(named: "favoriteFilled"), for: .normal)
        }
        
        let restaurantOperationsManager = RestaurantDBModelOperations()
        restaurantOperationsManager.update((self.restaurant?.isFavorite == false) ? true:false, restaurant: self.restaurant)

    }
    
    
}

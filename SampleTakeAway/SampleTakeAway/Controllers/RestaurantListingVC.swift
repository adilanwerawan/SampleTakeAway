//
//  RestaurantListingVC.swift
//  SampleTakeAway
//
//  Created by Adil Anwer on 9/28/19.
//  Copyright © 2019 Adil Anwer. All rights reserved.
//

import UIKit
import DropDown

class RestaurantListingVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var restaurantsTbl: UITableView?
    @IBOutlet weak var searchField: UITextField?
    @IBOutlet weak var sortButton: UIBarButtonItem?
    
    // MARK: - Variables
    let manager = RestaurantApiManager()
    var searchIsOn = false
    var filteredArray = [RestaurantDBModel]()
    var customSortBy = ""
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Restaurants"
        
        let requestParam = self.manager.getRestaurantApiParams()
        
        //Registering a restaurant table view cell
        self.restaurantsTbl?.register(UINib(nibName: CellNames.RestaurantCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIds.RestaurantCellId.rawValue)
        
        self.restaurantsTbl?.tableFooterView = UIView.init(frame: .zero)
        
        //Restaurant api call
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                
                DispatchQueue.main.async {
                    
                    self.restaurantsTbl?.reloadData()
                }
            }
        })
        
        dropDown.anchorView = self.searchField
        
        let sortValuesArray = ["bestMatch", "newest", "ratingAverage","distance", "popularity", "averageProductPrice","deliveryCosts", "minCost", "default"]
        //Datasource array is different than actual sort values as it contains First capital letter
        dropDown.dataSource = ["Best match", "Newest", "Rating average","Distance", "Popularity", "Average product price","Delivery costs", "Minimum cost", "Default"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.customSortBy = sortValuesArray[index]
            self.restaurantsTbl?.reloadData()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - IBActions and other functions
extension RestaurantListingVC{
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        
        dropDown.show()
    }
}

// MARK: - UITableViewDatasource and delegates
extension RestaurantListingVC : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidChangeEditing(){
        
        let searchText  = self.searchField?.text ?? ""
        
        if searchText.count > 0 {
            //            tableView.isHidden = false
            
            let resultPredicate = NSPredicate(format: "self contains[cd] %@", searchText)
            
            let filtered = self.manager.restaurantDBOperations.getAllRestaurants(self.customSortBy).filter {
                resultPredicate.evaluate(with: $0.restaurantName)
            }
            self.filteredArray = filtered
            self.searchIsOn = true
            self.restaurantsTbl?.reloadData()
        }
        else{
            
            self.searchIsOn = false
            self.restaurantsTbl?.reloadData()
            self.filteredArray = [RestaurantDBModel]()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchIsOn == true{
            
            return self.filteredArray.count
        }
        else{
            
            return self.manager.restaurantDBOperations.getAllRestaurants(self.customSortBy).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.RestaurantCellId.rawValue, for: indexPath) as! RestaurantCell
        
        var restaurant = self.manager.restaurantDBOperations.getAllRestaurants(self.customSortBy)[indexPath.row]
        if self.searchIsOn == true{
            
            restaurant = self.filteredArray[indexPath.row]
        }
        
        cell.config(restaurant: restaurant, sortBy: self.customSortBy)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.restaurantsTbl?.deselectRow(at: indexPath, animated: true)
    }
}

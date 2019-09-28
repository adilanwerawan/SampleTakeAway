//
//	Restaurant.swift
//
//	Create by Adil Anwer on 28/9/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class Restaurant : Codable {

	let name : String?
	let sortingValues : RestaurantSortingValue?
	let status : String?
	let restaurants : [Restaurant]?


	enum CodingKeys: String, CodingKey {
		case name = "name"
		case sortingValues
		case status = "status"
		case restaurants = "restaurants"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? String()
		sortingValues = try values.decodeIfPresent(RestaurantSortingValue.self, forKey: .sortingValues)  //?? RestaurantSortingValue()
		status = try values.decodeIfPresent(String.self, forKey: .status) ?? String()
		restaurants = try values.decodeIfPresent([Restaurant].self, forKey: .restaurants) ?? [Restaurant]()
	}


}
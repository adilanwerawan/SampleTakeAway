//
//	RestaurantSortingValue.swift
//
//	Create by Adil Anwer on 28/9/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class RestaurantSortingValue : Codable {

	let averageProductPrice : Int?
	let bestMatch : Float?
	let deliveryCosts : Int?
	let distance : Int?
	let minCost : Int?
	let newest : Float?
	let popularity : Float?
	let ratingAverage : Float?


	enum CodingKeys: String, CodingKey {
		case averageProductPrice = "averageProductPrice"
		case bestMatch = "bestMatch"
		case deliveryCosts = "deliveryCosts"
		case distance = "distance"
		case minCost = "minCost"
		case newest = "newest"
		case popularity = "popularity"
		case ratingAverage = "ratingAverage"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		averageProductPrice = try values.decodeIfPresent(Int.self, forKey: .averageProductPrice) ?? Int()
		bestMatch = try values.decodeIfPresent(Float.self, forKey: .bestMatch) ?? Float()
		deliveryCosts = try values.decodeIfPresent(Int.self, forKey: .deliveryCosts) ?? Int()
		distance = try values.decodeIfPresent(Int.self, forKey: .distance) ?? Int()
		minCost = try values.decodeIfPresent(Int.self, forKey: .minCost) ?? Int()
		newest = try values.decodeIfPresent(Float.self, forKey: .newest) ?? Float()
		popularity = try values.decodeIfPresent(Float.self, forKey: .popularity) ?? Float()
		ratingAverage = try values.decodeIfPresent(Float.self, forKey: .ratingAverage) ?? Float()
	}


}
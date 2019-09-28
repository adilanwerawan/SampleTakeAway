//
//  AFManagerProtocol.swift
//  RestaurantsApp
//
//  Created by Adil Anwer on 5/18/18.
//  Copyright © 2018 Adil Anwer. All rights reserved.
//

import Foundation

public protocol AFManagerProtocol {
    func api(_ param: AFParam, completion: @escaping () -> Void)
}

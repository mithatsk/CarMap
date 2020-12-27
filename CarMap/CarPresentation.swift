//
//  CarPresentation.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

struct CarPresentation {
    
    // MARK: - Properties
    
    var title: String
    var name: String
    var fuelLevel: String
    var fuelType: String
    var imageURL: String
    
    // MARK: - Initializer
    
    init(_ car: CarModel) {
        self.title = "\(car.make) - \(car.modelName)"
        self.name = car.name
        self.imageURL = car.carImageUrl
        self.fuelType = car.fuelType
        let fuelLevel = String(car.fuelLevel * 100).prefix(2)
        self.fuelLevel = "%\(fuelLevel)"
    }
    
}

//
//  CarsResponseModel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

typealias CarsResponseModel = [CarModel]
struct CarModel: Codable {
    let id, modelIdentifier, modelName, name: String
    let make, group, color, series: String
    let fuelType: String
    let fuelLevel: Double
    let transmission, licensePlate: String
    let latitude, longitude: Double
    let innerCleanliness: String
    let carImageUrl: String?
}

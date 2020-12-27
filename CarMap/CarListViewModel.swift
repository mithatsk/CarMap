//
//  CarListViewModel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

final class CarListViewModel: BaseViewModel {
    
    var cars: [CarModel] = []
    
    var isAscending: Bool = true {
        didSet {
            sortCarsByFuelLevel()
        }
    }
    
    func sortCarsByFuelLevel() {
        if isAscending {
            cars.sort { $0.fuelLevel < $1.fuelLevel }
        } else {
            cars.sort { $0.fuelLevel > $1.fuelLevel }
        }
        state = .show
    }
    
}

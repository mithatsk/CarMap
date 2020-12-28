//
//  MapViewModel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

final class MapViewModel: BaseViewModel {
    
    var cars: [CarModel] = []
    var annotations: [CarAnnotation] = []
    
    var dataProvider: MapDataProviderProtocol = MapDataProvider()
    
    func load() {
        dataProvider.fetchCars { [weak self] (response, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.description!)
                self.state = .error(error)
                return
            }
            if let cars = response {
                self.cars = cars
                self.state = .show
            }
        }
    }
    
    func getCar(with id: String) -> CarModel? {
        return cars.filter { $0.id == id }.first
    }
    
}

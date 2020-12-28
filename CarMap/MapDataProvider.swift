//
//  MapDataProvider.swift
//  CarMap
//
//  Created by mithat samet kaskara on 28.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

protocol MapDataProviderProtocol {
    func fetchCars(completion: ((CarsResponseModel?, NetworkError?) -> Void)?)
}

class MapDataProvider: BaseDataProvider, MapDataProviderProtocol {
    
    func fetchCars(completion: ((CarsResponseModel?, NetworkError?) -> Void)?) {
        let requestModel = CarsRequestModel()
        let transaction = CarsTransaction()
        service.fetch(transaction, requestModel: requestModel) { (response, error) in
            completion?(response, error)
        }
    }
    
}

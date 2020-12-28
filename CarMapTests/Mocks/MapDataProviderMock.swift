//
//  MapDataProviderMock.swift
//  CarMapTests
//
//  Created by mithat samet kaskara on 28.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation
@testable import CarMap

final class MapDataProviderMock: BaseDataProvider, MapDataProviderProtocol {
    
    private let stubFilePath = Bundle.unitTest.path(forResource: "cars_stub", ofType: "json")
    
    func fetchCars(completion: ((CarsResponseModel?, NetworkError?) -> Void)?) {
        guard let filePath = stubFilePath else {
            let error = NetworkError(description: "File path for stub does not exist.")
            completion?(nil, error)
            return
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            let jsonData = try Data(contentsOf: url, options: .mappedIfSafe)
            let response = try JSONDecoder().decode(CarsResponseModel.self, from: jsonData)
            completion?(response, nil)
        } catch {
            let error = NetworkError(description: error.localizedDescription)
            completion?(nil, error)
        }
    }
}

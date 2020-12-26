//
//  CarsTransaction.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

final class CarsTransaction: BaseTransaction<CarsRequestModel, CarsResponseModel> {
    
    override var path: String {
        return "codingtask"
    }
    
    required init() {
        super.init()
        endpoint = "/cars"
    }
    
}

//
//  NetworkError.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

struct NetworkError {
    
    var description: String!
    var errorCode: Int!
    
    init(description: String, errorCode: Int = 0) {
        self.description = description
        self.errorCode = errorCode
    }
}

//
//  BaseServiceProtocol.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

public protocol BaseServiceProtocol {
    func fetch<Transaction, RequestModel, ResponseModel>(_ transaction: Transaction, requestModel: RequestModel,
                                                         completion: ((ResponseModel?, NetworkError?) -> Void)?) where Transaction: BaseTransaction<RequestModel, ResponseModel>
}

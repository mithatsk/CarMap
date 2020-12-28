//
//  BaseService.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation
import Alamofire

public class BaseService: NSObject, BaseServiceProtocol {
    
    let indicatorPresenter: LoadingIndicatorPresenter = inject()
    
    public func fetch<Transaction, RequestModel, ResponseModel>(_ transaction: Transaction, requestModel: RequestModel,
                                                         completion: ((ResponseModel?, NetworkError?) -> Void)?) where Transaction: BaseTransaction<RequestModel, ResponseModel> {
        // Display Loading Indicator
        self.indicatorPresenter.show()
        
        guard var serviceUrl = ConfigurationHelper.shared.infoForKey(ConfigurationKeys.apiURL) else { return }
        
        // Configure service url
        serviceUrl.append(transaction.path)
        if let endpoint = transaction.endpoint {
            serviceUrl.append(endpoint)
        }
        
        // Configure header parameters
        let headers = [
            "Content-Type": "application/json"
        ]
        
        // Convert request model to json
        let encoder = JSONEncoder()
        guard let encodedJson = try? encoder.encode(requestModel),
            let encodedJsonDictionary = try? JSONSerialization.jsonObject(with: encodedJson, options: .allowFragments) as? [String: Any] else {
                return
        }
        
        // Make service request
        Alamofire.request(serviceUrl,
                          method: transaction.method.type,
                          parameters: encodedJsonDictionary,
                          headers: headers).responseData { (response) in
                            // Hide Loading Indicator
                            self.indicatorPresenter.hide()
                            switch response.result {
                            case .success(let value):
                                do {
                                    let responseValue = try JSONDecoder().decode(ResponseModel.self, from: value)
                                    completion?(responseValue, nil)
                                } catch let err {
                                    let error = NetworkError(description: err.localizedDescription)
                                    completion?(nil, error)
                                }
                            case .failure(let err):
                                let error = NetworkError(description: err.localizedDescription)
                                completion?(nil, error)
                            }
        }
    }
    
}


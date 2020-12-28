//
//  BaseTransaction.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

public class BaseTransaction<Request, Response> where Request: Encodable, Response: Decodable {
    
    open var path: String {
        return ""
    }
    
    open var endpoint: String?
    
    open var method: HTTPMethodType {
        return HTTPMethodType(type: .get)
    }
    
    public required init() { }
}

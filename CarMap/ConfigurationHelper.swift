//
//  ConfigurationHelper.swift
//  CarMap
//
//  Created by mithat samet kaskara on 29.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

public class ConfigurationHelper: NSObject {
    
    static let shared = ConfigurationHelper()
    
    func infoForKey(_ key: String) -> String? {
           return (Bundle.main.infoDictionary?[key] as? String)
    }
    
}

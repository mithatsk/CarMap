//
//  Localization.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

public final class Localization: NSObject, LocalizationProtocol {
    
    func string(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
}

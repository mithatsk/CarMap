//
//  Bundle+Test.swift
//  CarMapTests
//
//  Created by mithat samet kaskara on 28.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import XCTest
@testable import CarMap

extension Bundle {
    
    private class CarMapTest {}
    
    public class var unitTest: Bundle {
        return Bundle(for: CarMapTest.self)
    }
    
}

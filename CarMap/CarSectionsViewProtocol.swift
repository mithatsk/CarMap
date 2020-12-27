//
//  CarSectionsViewProtocol.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

protocol CarSectionsViewProtocol {
    var delegate: CarSectionsViewDelegate? { get set }
}

protocol CarSectionsViewDelegate: class {
    func displayCars()
}

//
//  CarSectionsView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class CarSectionsView: NibLoadableView, CarSectionsViewProtocol {

    weak var delegate: CarSectionsViewDelegate?
    
    public var frameHeight = CGFloat(122)
    public var bottomOffset = CGFloat(60)
    
    @IBAction private func showCarsButtonTapped(_ sender: UIButton) {
        delegate?.displayCars()
    }
    
}

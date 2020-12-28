//
//  CarSectionsView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class CarSectionsView: NibLoadableView, CarSectionsViewProtocol {

    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var fuelLevelNameLabel: BaseLabel!
    @IBOutlet private weak var fuelTypeNameLabel: BaseLabel!
    @IBOutlet private weak var fuelLevelLabel: UILabel!
    @IBOutlet private weak var fuelTypeLabel: UILabel!
    @IBOutlet private weak var selectCarView: UIView!
    @IBOutlet private weak var selectCarLabel: BaseLabel! {
        didSet {
            selectCarLabel.textAlignment = .center
        }
    }
    
    public var frameHeight = CGFloat(220)
    public var bottomOffset = CGFloat(60)
    
    public weak var delegate: CarSectionsViewDelegate?
    
    public func updateView(with car: CarPresentation) {
        fuelTypeNameLabel.localizableKey = "carCell.fuelType"
        fuelLevelNameLabel.localizableKey = "carCell.fuelLevel"
        fuelLevelLabel.text = car.fuelLevel
        fuelTypeLabel.text = car.fuelType
        titleLabel.text = car.title
        if let url = URL(string: car.imageURL) {
            carImageView.kf.setImage(with: url)
        }
        setDefaultCarImageIfImageIsNil()
        selectCarView.isHidden = true
    }
    
    private func setDefaultCarImageIfImageIsNil() {
        if carImageView.image == nil {
            carImageView.image = UIImage(named: ImageNames.defaultCarImage.rawValue)
        }
    }
    
    @IBAction private func showCarsButtonTapped(_ sender: UIButton) {
        delegate?.displayCars()
    }
    
}

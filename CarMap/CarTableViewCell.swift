//
//  CarTableViewCell.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class CarTableViewCell: UITableViewCell {

    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var fuelLevelLabel: UILabel!
    @IBOutlet private weak var fuelTypeLabel: UILabel!
    
    func configure(with car: CarModel) {
        selectionStyle = .none
        let fuelLevel = String(car.fuelLevel * 100).prefix(2)
        fuelLevelLabel.text = "%\(fuelLevel)"
        fuelTypeLabel.text = car.fuelType
        titleLabel.text = "\(car.make) - \(car.modelName)"
        nameLabel.text = car.name
        if let url = URL(string: car.carImageUrl) {
            carImageView.kf.setImage(with: url)
        }
        setDefaultCarImageIfImageIsNil()
    }
    
    private func setDefaultCarImageIfImageIsNil() {
        if carImageView.image == nil {
            carImageView.image = UIImage(named: ImageNames.defaultCarImage.rawValue)
        }
    }
    
}

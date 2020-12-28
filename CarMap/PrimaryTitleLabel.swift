//
//  PrimaryTitleLabel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class PrimaryTitleLabel: BaseLabel {

    override func commonInitialize() {
        super.commonInitialize()
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textColor = Colors.orange
    }

}

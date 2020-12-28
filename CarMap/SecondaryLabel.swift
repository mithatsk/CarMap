//
//  SecondaryLabel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class SecondaryLabel: BaseLabel {

    override func commonInitialize() {
        super.commonInitialize()
        font = UIFont.systemFont(ofSize: 13, weight: .medium)
        textColor = Colors.dark
    }

}

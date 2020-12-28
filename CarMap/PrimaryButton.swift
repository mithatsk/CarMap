//
//  PrimaryButton.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

@IBDesignable
final class PrimaryButton: BaseButton {
    
    override public func commonInitialize() {
        super.commonInitialize()
        backgroundColor = Colors.orange
        setTitleColor(Colors.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    }
}

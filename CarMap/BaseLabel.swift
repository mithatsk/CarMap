//
//  BaseLabel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

@IBDesignable
public class BaseLabel: UILabel {
    
    var localization: Localization = inject()
    
    @IBInspectable var localizableKey: String! = "" {
        didSet {
            self.text = localization.string(for: localizableKey)
        }
    }
    
    @IBInspectable var customTextColor: UIColor! = Colors.darkBlack {
        didSet {
            self.textColor = customTextColor
        }
    }
    
    @IBInspectable var acessibilityIdentifierKey: String? {
        didSet {
            accessibilityIdentifier = acessibilityIdentifierKey
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitialize()
    }

    func commonInitialize() {
        font = .systemFont(ofSize: 17, weight: .medium)
        textAlignment = .left
        numberOfLines = 0
    }
    
}



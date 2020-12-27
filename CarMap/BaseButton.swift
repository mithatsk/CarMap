//
//  BaseButton.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

@IBDesignable
public class BaseButton: UIButton {
    
    var localization: Localization = inject()
    
    @IBInspectable var localizableKey: String! = "" {
        didSet {
            setTitle(localization.string(for: localizableKey), for: .normal)
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
    
    public func commonInitialize() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
}

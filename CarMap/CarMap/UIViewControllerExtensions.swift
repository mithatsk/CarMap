//
//  UIViewControllerExtensions.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate(from storyboardName: String) -> UIViewController {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className)
    }
    
}

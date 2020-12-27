//
//  DialogAlertDelegate.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

protocol DialogAlertDelegate: class {
    func primaryButtonTapped(dialog: DialogAlertView)
    func secondaryButtonTapped(dialog: DialogAlertView)
}

extension DialogAlertDelegate {
    func secondaryButtonTapped(dialog: DialogAlertView) { }
}

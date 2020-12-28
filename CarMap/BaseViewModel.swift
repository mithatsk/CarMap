//
//  BaseViewModel.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

enum State {
    case `default`
    case show
    case error(_ error: NetworkError)
}

protocol BaseViewModelDelegate: class {
    func stateDidChange(_ state: State)
}

public class BaseViewModel: NSObject {
    
    weak var delegate: BaseViewModelDelegate?
    
    var state: State! {
        didSet {
            delegate?.stateDidChange(state)
        }
    }
    
    required override init() { }
    
}


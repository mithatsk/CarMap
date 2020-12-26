//
//  BaseViewController.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

public class BaseViewController<ViewModel: BaseViewModel>: UIViewController, BaseViewModelDelegate {
    
    var viewModel: ViewModel!
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = ViewModel()
        self.viewModel.delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func stateDidChange(_ state: State) {
        switch state {
        case .show:
            self.showState()
        case .error(let error):
            self.showError(error)
        case .default:
            break
        }
    }
    
    func showState() {
        print("show")
    }
    
    func showError(_ error: NetworkError) {
        // TODO: Alert will be displayed
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}

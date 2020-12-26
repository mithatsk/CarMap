//
//  LoadingIndicatorPresenter.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class LoadingIndicatorPresenter: NSObject {
    
    private let loadingViewSize: CGFloat = 60
    private var loadingView: LoadingIndicatorView?
    private var backgroundView: UIView? {
        didSet {
            backgroundView?.backgroundColor = .black
            backgroundView?.alpha = 0.5
            backgroundView?.isUserInteractionEnabled = true
        }
    }
    
    private var counter: Int = 0
    
    func show() {
        if counter == 0 {
            self.initializeLoadingView()
        }
        
        counter = counter + 1
    }
    
    func hide() {
        if counter > 0 {
            counter = counter - 1
        }
        
        if counter == 0 {
            self.backgroundView?.removeFromSuperview()
            self.loadingView?.removeFromSuperview()
            self.backgroundView = nil
            self.loadingView = nil
        }
    }
    
    private func initializeLoadingView() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        if self.backgroundView == nil {
            self.backgroundView = UIView(frame: window.frame)
            window.addSubview(self.backgroundView!)
        }
        
        if self.loadingView == nil {
            self.loadingView = LoadingIndicatorView(frame: CGRect(x: (window.frame.midX - self.loadingViewSize / 2), y: (window.frame.midY - self.loadingViewSize / 2), width: self.loadingViewSize, height: self.loadingViewSize))
            window.addSubview(self.loadingView!)
        }
        
        self.loadingView?.rotate()
    }
    
}

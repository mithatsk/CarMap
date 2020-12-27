//
//  NibLoadableView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

public class NibLoadableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let className = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let nib = UINib(nibName: className, bundle: nil)
        
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.frame
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

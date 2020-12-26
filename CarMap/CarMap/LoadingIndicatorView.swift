//
//  LoadingIndicatorView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class LoadingIndicatorView: UIView {
    
    private let lineWidth: CGFloat = 4.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .clear
        self.initializeSpinner()
    }
    
    private func initializeSpinner() {
        addBezierPath(startAngle: 0, endAngle: (1.5 * .pi), color: Colors.yellow.cgColor)
        addBezierPath(startAngle: (1.5 * .pi), endAngle: (2 * .pi), color: Colors.lightGray.cgColor)
    }
    
    private func addBezierPath(startAngle: CGFloat, endAngle: CGFloat, color: CGColor) {
        let layer =  CAShapeLayer()
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let bezierPath: UIBezierPath = UIBezierPath(arcCenter: center, radius: (self.frame.width / 2) - lineWidth, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        layer.path = bezierPath.cgPath
        layer.strokeColor = color
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineWidth
        layer.strokeEnd = 1
        self.layer.addSublayer(layer)
    }
    
    func rotate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
}

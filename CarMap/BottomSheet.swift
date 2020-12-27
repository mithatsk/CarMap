//
//  BottomSheet.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

public protocol BottomSheetDelegate: class {
    func dismissed(bottomSheet: BottomSheet)
}

public class BottomSheet: UIView {

    // MARK: - Public Properties

    public var animationDuration = Double(0.3)
    public var shouldDismissOnScroll: Bool = true
    public var shadowRadius = CGFloat(4)
    public var shadowOpacity = Float(0.3)
    public var shadowOffset = CGSize(width: 0, height: -4)
    public var shadowColor = Colors.dark.cgColor
    public var bottomBorderOffset = CGFloat(100)

    // MARK: - Private Properties

    private var topBorderYPosition: CGFloat {
        if frame.height >= screenHeight - safeAreaTop {
            return screenHeight - frame.height + safeAreaTop
        } else {
            return screenHeight - frame.height
        }
    }

    private var safeAreaTop: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 00
    }

    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    private var bottomBorderYPosition: CGFloat {
        return UIScreen.main.bounds.maxY
    }

    private var swipedUp: Bool {
        return movement < 0
    }

    private var swipedDown: Bool {
        return movement > 0
    }

    private var bottomSheetHeight: CGFloat {
        return screenHeight - topBorderYPosition
    }

    private var currentYPosition: CGFloat {
        return frame.origin.y
    }

    private var movement = CGFloat(0)

    private var contentViewController: UIViewController?
    private var contentView: UIView!
    private var parentView: UIView?

    public weak var delegate: BottomSheetDelegate?

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Custom Initializers

    public init(contentView: UIView) {
        super.init(frame: .zero)
        self.contentView = contentView
        addContentView(contentView: contentView)
        setupBottomSheet()
    }

    public init(contentViewController: UIViewController) {
        super.init(frame: .zero)
        self.contentViewController = contentViewController
        self.contentView = contentViewController.view
        addContentView(contentView: contentViewController.view)
        setupBottomSheet()
    }

    // MARK: - View Configuration Methods

    private func setupBottomSheet() {
        bringSubviewToFront(contentView)
        addShadow()
        addPanGesture()
    }
    
    private func addShadow() {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(gestureRecognizer:)))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }

    private func addContentView(contentView: UIView) {
        var contentViewHeight: CGFloat = contentView.frame.height
        if contentViewHeight >= screenHeight {
            contentViewHeight = screenHeight
        }
        contentView.frame = CGRect(x: 0.0, y: 0, width: contentView.frame.width, height: contentViewHeight)
        frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: contentView.frame.height)
        addSubview(contentView)
    }

    public func present(in viewController: UIViewController? = nil) {
        addBottomSheet(to: viewController?.view)
        display()
    }

    private func addBottomSheet(to view: UIView?) {
        if let view = view {
            parentView = view
            view.addSubview(self)
        } else if let window = UIApplication.shared.keyWindow {
            parentView = window
            window.addSubview(self)
        }
    }

    func display() {
        parentView?.bringSubviewToFront(self)
        UIView.animate(withDuration: animationDuration) { [weak self] in
            guard let self = self else { return }

            self.frame = CGRect(x: self.frame.origin.x, y: self.topBorderYPosition, width: self.frame.width, height: self.frame.height)
            self.layoutIfNeeded()
        }
    }

    // MARK: - Boundary and stop point calculation methods

    private func isOutOfBounds(translation: CGFloat) -> Bool {
        return (currentYPosition + translation) < topBorderYPosition || (currentYPosition + translation) > (bottomBorderYPosition)
    }

    private func findStopPoint(yPosition: CGFloat) -> CGFloat? {
        var nearestPoint: CGFloat? = topBorderYPosition
        if swipedUp {
            if yPosition >= topBorderYPosition {
                nearestPoint = topBorderYPosition
            }
        } else if swipedDown {
            if yPosition <= topBorderYPosition {
                nearestPoint = topBorderYPosition
            } else {
                nearestPoint = bottomBorderYPosition - bottomBorderOffset
            }
        } else {
            return nil
        }

        return nearestPoint
    }

    public func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            guard let self = self else { return }
            self.frame.origin.y = self.bottomBorderYPosition
        }) { [weak self] _ in
            guard let self = self else { return }
            guard let completion = completion else {
                self.delegate?.dismissed(bottomSheet: self)
                self.remove()
                return
            }
            self.delegate?.dismissed(bottomSheet: self)
            completion()
            self.remove()
        }
    }

    private func dismissOnScroll() {
        if shouldDismissOnScroll {
            dismiss()
        }
    }

    private func remove() {
        removeFromSuperview()
        contentViewController = nil
    }

}

// MARK: - UIGesture Delegate Implementation

extension BottomSheet: UIGestureRecognizerDelegate {
    
    @objc private func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)

        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {

            if isOutOfBounds(translation: translation.y) {
                return
            }

            if translation.y != 0.0 {
                movement = translation.y
            }

            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint(x: 0.0, y: 0.0), in: self)
        }

        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            if swipedDown && self.isOutOfBounds(translation: self.movement) {
                dismissOnScroll()
                return
            }

            let nearestStopPoint: CGFloat? = findStopPoint(yPosition: currentYPosition)
            movement = 0.0
            guard let nearestPoint = nearestStopPoint else { return }

            if nearestPoint == bottomBorderYPosition {
                dismissOnScroll()
                return
            }

            UIView.animate(withDuration: animationDuration) {
                [weak self] in
                guard let self = self else { return }

                self.frame = CGRect(x: self.frame.origin.x, y: nearestPoint, width: self.frame.width, height: self.frame.height)
            }
        }
    }
    
}

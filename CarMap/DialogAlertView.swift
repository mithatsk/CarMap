//
//  DialogAlertView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import Foundation

import UIKit

final class DialogAlertView: UIView {
    
    // MARK: - Constants
    
    private let animationDuration: Double = 0.3
    private let imageViewWidthHeight: CGFloat = 48.0
    private let margin: CGFloat = 20.0
    private let buttonHeight: CGFloat = 45
    private let cornerRadius: CGFloat = 10.0
    
    // MARK: - UI Properties
    
    private lazy var primaryButton: UIButton! = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = self.cornerRadius
        button.backgroundColor = Colors.orange
        button.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("alert.primaryButtonTittle", comment: ""), for: .normal)
        return button
    }()
    
    private lazy var secondaryButton: UIButton! = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = self.cornerRadius
        button.backgroundColor = Colors.lightGray
        button.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("alert.secondaryButtonTittle", comment: ""), for: .normal)
        button.setTitleColor(Colors.dark, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.darkBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = Colors.dark
        return label
    }()
    
    private lazy var imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.warningIcon.rawValue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var backgroundView: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dialogView: UIView! = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = self.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public weak var delegate: DialogAlertDelegate?
    
    // MARK: - Initializer
    
    public init(delegate: DialogAlertDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @objc private func primaryButtonTapped() {
        dismiss() {
            self.delegate?.primaryButtonTapped(dialog: self)
        }
    }
    
    @objc private func secondaryButtonTapped() {
        dismiss() {
            self.delegate?.secondaryButtonTapped(dialog: self)
        }
    }
    
    public func dismiss(completion: (()-> Void)? = nil) {
        backgroundView.removeFromSuperview()
        removeFromSuperview()
        completion?()
    }
    
    private func setupView() {
        addBackgroundView()
        addSubViewsToStackView()
        dialogView.addSubview(stackView)
        addSubview(dialogView)
        addConstraintsToStackViewElements()
        addConstraintsToStackView()
        addConstraintsToDialogView()
    }
    
    private func addSubViewsToStackView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(primaryButton)
        stackView.addArrangedSubview(secondaryButton)
    }
    
    private func addConstraintsToStackViewElements() {
        imageView.heightAnchor.constraint(equalToConstant: imageViewWidthHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageViewWidthHeight).isActive = true
        primaryButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        primaryButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        secondaryButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        secondaryButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    private func addConstraintsToStackView() {
        stackView.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: margin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -margin).isActive = true
        stackView.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -margin).isActive = true
        stackView.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: margin).isActive = true
    }
    
    private func addConstraintsToDialogView() {
        dialogView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin).isActive = true
        dialogView.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    public func show(titleText: String, descriptionText: String, primaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil) {
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        if let title = primaryButtonTitle {
            primaryButton.setTitle(title, for: .normal)
        }
        
        if let title = secondaryButtonTitle {
            secondaryButton.setTitle(title, for: .normal)
        } else {
            secondaryButton.isHidden = true
        }
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self)
            addView(into: window)
        }
    }
    
    private func addBackgroundView() {
        addSubview(backgroundView)
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    private func addView(into window: UIWindow) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: window.topAnchor).isActive = true
    }
    
}

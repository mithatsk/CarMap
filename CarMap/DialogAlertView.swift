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
        self.dismiss() {
            self.delegate?.primaryButtonTapped(dialog: self)
        }
    }
    
    @objc private func secondaryButtonTapped() {
        self.dismiss() {
            self.delegate?.secondaryButtonTapped(dialog: self)
        }
    }
    
    public func dismiss(completion: (()-> Void)? = nil) {
        self.backgroundView.removeFromSuperview()
        self.removeFromSuperview()
        completion?()
    }
    
    private func setupView() {
        addBackgroundView()
        addSubViewsToStackView()
        self.dialogView.addSubview(self.stackView)
        self.addSubview(self.dialogView)
        addConstraintsToStackViewElements()
        addConstraintsToStackView()
        addConstraintsToDialogView()
    }
    
    private func addSubViewsToStackView() {
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(descriptionLabel)
        self.stackView.addArrangedSubview(primaryButton)
        self.stackView.addArrangedSubview(secondaryButton)
    }
    
    private func addConstraintsToStackViewElements() {
        self.imageView.heightAnchor.constraint(equalToConstant: self.imageViewWidthHeight).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.imageViewWidthHeight).isActive = true
        self.primaryButton.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.primaryButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        self.secondaryButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        self.secondaryButton.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
    }
    
    private func addConstraintsToStackView() {
        self.stackView.leftAnchor.constraint(equalTo: self.dialogView.leftAnchor, constant: self.margin).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.dialogView.bottomAnchor, constant: -self.margin).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.dialogView.rightAnchor, constant: -self.margin).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.dialogView.topAnchor, constant: self.margin).isActive = true
    }
    
    private func addConstraintsToDialogView() {
        self.dialogView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.margin).isActive = true
        self.dialogView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.margin).isActive = true
        self.dialogView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func show(titleText: String, descriptionText: String, primaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil) {
        self.titleLabel.text = titleText
        self.descriptionLabel.text = descriptionText
        if let title = primaryButtonTitle {
            self.primaryButton.setTitle(title, for: .normal)
        }
        
        if let title = secondaryButtonTitle {
            self.secondaryButton.setTitle(title, for: .normal)
        } else {
            self.secondaryButton.isHidden = true
        }
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self)
            self.addView(into: window)
        }
    }
    
    private func addBackgroundView() {
        self.addSubview(self.backgroundView)
        self.backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func addView(into window: UIWindow) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
    }
    
}

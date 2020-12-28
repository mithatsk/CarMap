//
//  CarAnnotationView.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

final class CarAnnotationView: MKAnnotationView {
    
    // MARK: - Constants
    
    private let triangleInset = CGFloat(10)
    private let contentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 5)
    private let shadowOpacity = Float(0.4)
    private let shadowRadius = CGFloat(2)
    private let shadowOffset = CGSize(width: 0, height: 2)
    
    // MARK: - Properties
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: ImageNames.defaultCarImage.rawValue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var intrinsicContentSize: CGSize {
        var size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width += contentInsets.left + contentInsets.right
        size.height += contentInsets.top + contentInsets.bottom
        return size
    }
    
    var id: String!
    
    // MARK: - Override Methods
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        configureViews()
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentSize = intrinsicContentSize
        setFramePosition(contentSize: contentSize)
        drawTriangleAndRoundCorners(contentSize: contentSize)
    }
    
    // MARK: - Custom Methods
    
    private func setFramePosition(contentSize: CGSize) {
        invalidateIntrinsicContentSize()
        frame.size = intrinsicContentSize
        centerOffset = CGPoint(x: 0, y: -contentSize.height / 2)
    }
    
    private func drawTriangleAndRoundCorners(contentSize: CGSize) {
        let shape = CAShapeLayer()
        let path = CGMutablePath()
        
        let pointShape = UIBezierPath()
        pointShape.move(to: CGPoint(x: (contentSize.width - triangleInset) / 2, y: contentSize.height - triangleInset/2))
        pointShape.addLine(to: CGPoint(x: (contentSize.width / 2), y: contentSize.height))
        pointShape.addLine(to: CGPoint(x: ((contentSize.width + triangleInset) / 2), y: contentSize.height - triangleInset/2))
        path.addPath(pointShape.cgPath)

        let box = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - triangleInset/2)
        let bezierPath = UIBezierPath(roundedRect: box,
                                       byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 5, height: 5)).cgPath
        path.addPath(bezierPath)
        
        addShadow(path: bezierPath)

        shape.path = path
        backgroundView.layer.mask = shape
    }
    
    private func addShadow(path: CGPath) {
        layer.shadowPath = path
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = UIColor.black.cgColor
    }
    
    private func setupViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: contentInsets.left).isActive = true
        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: contentInsets.top).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func configureViews() {
        if let annotation  = self.annotation as? CarAnnotation {
            id = annotation.id
            accessibilityIdentifier = "CarAnnotation-\(annotation.id)"
            setImage(string: annotation.imageURL)
        }
    }
    
    private func setImage(string: String?) {
        if let imageURLString = string, let imageURL = URL(string: imageURLString) {
            imageView.kf.setImage(with: imageURL) { result in
                switch result {
                case .success(let value):
                    self.imageView.image = value.image
                case .failure(let error):
                    self.imageView.image = UIImage(named: ImageNames.defaultCarImage.rawValue)
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
}

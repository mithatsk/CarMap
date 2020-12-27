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
    
    // MARK: - Properties
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
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
        setImage()
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
        let roundedRect = UIBezierPath(roundedRect: box,
                                       byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight],
                                       cornerRadii: CGSize(width: 5, height: 5))
        path.addPath(roundedRect.cgPath)

        shape.path = path
        backgroundView.layer.mask = shape
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
    
    private func setImage() {
        if let annotation  = self.annotation as? CarAnnotation,
            let imageString = annotation.imageURL,
            let imageURL = URL(string: imageString) {
            
            KingfisherManager.shared.retrieveImage(with: imageURL, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, imageURL) in
                guard let self = self else { return }
                if let image = image {
                    self.imageView.image = image
                }
            }
        }
    }
    
}

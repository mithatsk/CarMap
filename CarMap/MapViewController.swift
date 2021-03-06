//
//  MapViewController.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: BaseViewController<MapViewModel> {
    
    // MARK: - Constants
    
    private let scaleRatio = CGFloat(1.5)
    
    // MARK: - UI Properties
    
    private var carSectionsView: CarSectionsView?
    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CarAnnotation.self))
        addCarSectionsView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }
    
    // MARK: - Custom Methods
    
    private func setAnotations() {
        for car in viewModel.cars {
            let annotation = CarAnnotation(id: car.id, coordinate: CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude))
            annotation.imageURL = car.carImageUrl
            viewModel.annotations.append(annotation)
        }
    }
    
    private func addAnnotationsToMap() {
        for annotation in viewModel.annotations {
            mapView.addAnnotation(annotation)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    private func centerMapToAnnotations() {
        let annotations = viewModel.annotations
        let centerLatitute = annotations.map { $0.coordinate.latitude }.reduce(0, +) / Double(annotations.count)
        let centerLongitude = annotations.map { $0.coordinate.longitude }.reduce(0, +) / Double(annotations.count)
        
        let initialLocation = CLLocation(latitude: centerLatitute, longitude: centerLongitude)
        mapView.centerToLocation(initialLocation)
    }
    
    private func addCarSectionsView() {
        carSectionsView = CarSectionsView()
        guard let carSectionsView = carSectionsView else { return }
        carSectionsView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: carSectionsView.frameHeight))
        carSectionsView.delegate = self
        let bottomSheet = BottomSheet(contentView: carSectionsView)
        bottomSheet.bottomBorderOffset = carSectionsView.bottomOffset
        bottomSheet.shouldDismissOnScroll = false
        bottomSheet.present(in: self)
    }
    
    override func showState() {
        setAnotations()
        addAnnotationsToMap()
        centerMapToAnnotations()
    }
    
}

// MARK: - MKMapViewDelegate Implementation

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? CarAnnotation {
            annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: NSStringFromClass(CarAnnotation.self))
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.transform = CGAffineTransform.init(scaleX: scaleRatio, y: scaleRatio)
        if let annotationView = view as? CarAnnotationView, let carModel = viewModel.getCar(with: annotationView.id) {
            let carPresentation = CarPresentation(carModel)
            carSectionsView?.updateView(with: carPresentation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.transform = CGAffineTransform.identity
    }
    
}

extension MapViewController: CarSectionsViewDelegate {
    
    func displayCars() {
        let viewController = CarListViewController.instantiate(from: StoryboardNames.list.rawValue) as! CarListViewController
        viewController.viewModel.cars = viewModel.cars
        show(viewController, sender: self)
    }
    
}

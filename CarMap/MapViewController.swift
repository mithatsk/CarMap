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
    
    // MARK: - IBOutlet Properties
    
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
    
    override func showState() {
        setAnotations()
        addAnnotationsToMap()
        centerMapToAnnotations()
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
        let view = CarSectionsView()
        view.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: view.frameHeight))
        view.delegate = self
        let bottomSheet = BottomSheet(contentView: view)
        bottomSheet.bottomBorderOffset = view.bottomOffset
        bottomSheet.shouldDismissOnScroll = false
        bottomSheet.present(in: self)
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
    
}

extension MapViewController: CarSectionsViewDelegate {
    
    func displayCars() {
        // TODO: Display Car list
    }
    
}

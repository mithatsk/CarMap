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
    
    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            // TODO: Set mapView delegate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    
    override func showState() {
        
    }
    
}

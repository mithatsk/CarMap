//
//  CarAnnotation.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    var id: String
    var imageURL: String?
    
    init(id: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.id = id
        super.init()
    }
    
}

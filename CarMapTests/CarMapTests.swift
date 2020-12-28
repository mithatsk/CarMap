//
//  CarMapTests.swift
//  CarMapTests
//
//  Created by mithat samet kaskara on 28.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import XCTest
@testable import CarMap

class CarMapTests: XCTestCase {
    
    var mapViewController: MapViewController!

    override func setUp() {
        super.setUp()
        mapViewController = initializeMapViewController()
        mapViewController.viewModel.dataProvider = MapDataProviderMock()
    }

    private func initializeMapViewController() -> MapViewController {
        return MapViewController.instantiate(from: StoryboardNames.map.rawValue) as! MapViewController
    }
    
    func testCars() {
        // Model is not loaded state should be nil and there should not be any cars
        XCTAssertEqual(mapViewController.viewModel.cars.count, 0)
        XCTAssertNil(mapViewController.viewModel.state)
        
        mapViewController.viewDidLoad()
        mapViewController.viewDidAppear(true)
        
        // Fetched cars so amount of cars should match the stub data and state should not be nil
        XCTAssertEqual(mapViewController.viewModel.cars.count, 3)
        XCTAssertNotNil(mapViewController.viewModel.state)
        
        // Fuel level of cars should match the stub data
        
        XCTAssertEqual(mapViewController.viewModel.cars[0].fuelLevel, 0.7)
        XCTAssertEqual(mapViewController.viewModel.cars[1].fuelLevel, 0.4)
        XCTAssertEqual(mapViewController.viewModel.cars[2].fuelLevel, 0.4)
    }
    
    func testAnnotations() {
        // Annotations array should be empty at first
        XCTAssertEqual(mapViewController.viewModel.annotations.count, 0)
        
        mapViewController.viewDidLoad()
        mapViewController.viewDidAppear(true)
        
        // There should be 3 cars and 3 annotations after data is fetched
        XCTAssertEqual(mapViewController.viewModel.annotations.count, 3)
        XCTAssertEqual(mapViewController.viewModel.annotations.count, mapViewController.viewModel.cars.count)
        
        // Image urls from stub data should match the annotations
        let firstAnnotationImageURL = "https://cdn.sixt.io/codingtask/images/mini.png"
        XCTAssertEqual(mapViewController.viewModel.annotations[0].imageURL, firstAnnotationImageURL)
        let secondAnnotationImageURL = "https://cdn.sixt.io/codingtask/images/mini_countryman.png"
        XCTAssertNotEqual(mapViewController.viewModel.annotations[0].imageURL, secondAnnotationImageURL)
        XCTAssertEqual(mapViewController.viewModel.annotations[1].imageURL, secondAnnotationImageURL)
    }
    
    override func tearDown() {
        super.tearDown()
        mapViewController = nil
    }

}

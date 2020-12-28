//
//  CarListViewControllerTests.swift
//  CarMapTests
//
//  Created by mithat samet kaskara on 28.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import XCTest
@testable import CarMap

class CarListViewControllerTests: XCTestCase {
    
    var viewController: CarListViewController!
    
    override func setUp() {
        super.setUp()
        viewController = initializeCarListViewController()
    }
    
    private func initializeCarListViewController() -> CarListViewController {
        let viewController = CarListViewController.instantiate(from: StoryboardNames.list.rawValue) as! CarListViewController
        let dataProvider = MapDataProviderMock()
        dataProvider.fetchCars { (response, error) in
            if let cars = response {
                viewController.viewModel.cars = cars
            }
        }
        return viewController
    }
    
    func testSortCarsByFuelLevel() {
        viewController.viewDidLoad()
        
        // Cars should be sorted by highest fuel level first after viewDidLoad
        XCTAssert(viewController.viewModel.cars[0].fuelLevel >= viewController.viewModel.cars[1].fuelLevel)
        XCTAssert(viewController.viewModel.cars[1].fuelLevel >= viewController.viewModel.cars[2].fuelLevel)
        
        // Sort by lowest fuel level first
        viewController.viewModel.isAscending = true
        
        // Cars should be sorted by lowest fuel level first
        XCTAssert(viewController.viewModel.cars[0].fuelLevel <= viewController.viewModel.cars[1].fuelLevel)
        XCTAssert(viewController.viewModel.cars[1].fuelLevel <= viewController.viewModel.cars[2].fuelLevel)
    }
    
    func testNumberOfRows() {
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), viewController.viewModel.cars.count)
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
}

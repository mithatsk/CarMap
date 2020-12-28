//
//  CarListViewController.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class CarListViewController: BaseViewController<CarListViewModel> {
    
    // MARK: - Constants
    
    private let rowHeight = CGFloat(110)
    
    // MARK: - UI Properties
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display from highest fuel level to lowest
        viewModel.isAscending = false
    }
    
    // MARK: - Custom Methods
    
    private func configureTableView() {
        let nib = UINib(nibName: TableViewCellIdentifiers.car.rawValue, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: TableViewCellIdentifiers.car.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction private func sortButtonTapped(_ sender: UIButton) {
        viewModel.isAscending = !viewModel.isAscending
    }
    
    @IBAction private func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func showState() {
        tableView.reloadData()
    }
    
}

extension CarListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.car.rawValue, for: indexPath) as? CarTableViewCell {
            let carModel = viewModel.cars[indexPath.row]
            let carPresentation = CarPresentation(carModel)
            cell.configure(with: carPresentation)
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension CarListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
}

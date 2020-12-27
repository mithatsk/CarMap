//
//  CarListViewController.swift
//  CarMap
//
//  Created by mithat samet kaskara on 27.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

final class CarListViewController: BaseViewController<CarListViewModel> {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: TableViewCellIdentifiers.car.rawValue, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: TableViewCellIdentifiers.car.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension CarListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.car.rawValue, for: indexPath) as? CarTableViewCell {
            let car = viewModel.cars[indexPath.row]
            cell.configure(with: car)
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension CarListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

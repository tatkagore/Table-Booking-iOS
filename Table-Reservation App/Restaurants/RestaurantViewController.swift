//
//  RestaurantsViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import UIKit

protocol RestaurantsDisplayer: AnyObject {
    func setup(viewModel: [Restaurant])
}

class RestaurantsViewController: UIViewController {

    // MARK: - Properties

    let tableView = UITableView()
    var restaurantData: [Restaurant] = []
    var presenter: RestaurantsPresenter

    // MARK: - Initialization

    init(presenter: RestaurantsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        // Create a title label
        let titleLabel = UILabel()
        titleLabel.text = "Berry Table🫐"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)

        // Set up constraints for the title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        // Set up constraints for the tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Initialize the presenter and trigger the initial data setup
        presenter = RestaurantsPresenterImpl()
        presenter.bind(displayer: self)
        presenter.onViewDidLoad()
    }

}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        // Configure the cell with restaurant data
        let restaurant = restaurantData[indexPath.row]
        cell.textLabel?.text = restaurant.name

        return cell
    }
}


// MARK: - RestaurantsDisplayer

extension RestaurantsViewController: RestaurantsDisplayer {
    func setup(viewModel: [Restaurant]) {
         restaurantData = viewModel
         tableView.reloadData()
      }
}

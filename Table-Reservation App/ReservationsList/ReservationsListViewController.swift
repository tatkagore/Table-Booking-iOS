//
//  ReservationsListViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import Foundation
import UIKit

protocol ReservationsListDisplayer: AnyObject {
    func showReservations(_ reservations: [ReservationModel])
    func showError(_ error: Error)
}

protocol ReservationsListPresenterDelegate: AnyObject {
}

class ReservationsListViewController: UIViewController {
    let presenter: ReservationsListPresenter = ReservationsListsPresenterImpl()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReservationTableViewCell.self, forCellReuseIdentifier: ReservationTableViewCell.identifier)
        return tableView
    }()

    var reservations: [ReservationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.bind(displayer: self)
        configureTableView()
        presenter.fetchCurrentReservations()

    }

    func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.rowHeight = 90
        tableView.tableViewConstraints(to: view)
        tableView.separatorStyle = .none
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReservationsListViewController: ReservationsListDisplayer {
    func showReservations(_ reservations: [ReservationModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.reservations = reservations
            self?.tableView.reloadData()
        }
    }

    func showError(_ error: Error) {
        print(error)
    }
}


extension ReservationsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }

    // What cells to show? as -> ReservationTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservationTableViewCell.identifier, for: indexPath) as! ReservationTableViewCell
        let reservation = reservations[indexPath.row]
        cell.configure(with: reservation)
        return cell
    }
}

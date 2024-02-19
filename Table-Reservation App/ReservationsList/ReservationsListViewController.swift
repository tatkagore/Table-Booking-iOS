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
    func fetchedUser(with user: UserModel)
}

protocol ReservationsListPresenterDelegate: AnyObject {
}

class ReservationsListViewController: UIViewController {
    let presenter: ReservationsListPresenter
    var user: UserModel?

    init(presenter: ReservationsListPresenter, user: UserModel? = nil) {
        self.presenter = presenter
        self.user = user
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userCardView = UserCardView()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReservationTableViewCell.self, forCellReuseIdentifier: ReservationTableViewCell.identifier)
        return tableView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Your reservations"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.sizeToFit()
        return titleLabel
    }()

    var profileButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("go", for: .normal)
        button.addTarget(self, action: #selector(userProfileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    var reservations: [ReservationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.titleView = titleLabel

        presenter.bind(displayer: self)
        configureUserCardView()
        configureButton()
        configureTableView()
        presenter.onViewDidLoad()

    }

    private func configureUserCardView() {
        userCardView.configure(with: user?.firstName ?? "No User Found :(", email: user?.email ?? "@NoEmailFound :(", image: UIImage(named: "avatar") ?? UIImage())
        view.addSubview(userCardView)
        userCardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userCardView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func configureButton(){
        view.addSubview(profileButton)

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: 20),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }


    @objc func userProfileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.user = user
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }


}

extension ReservationsListViewController: ReservationsListDisplayer {
    // display user
    func fetchedUser(with user: UserModel) {
        DispatchQueue.main.async { [weak self] in
            self?.user = user
            self?.configureUserCardView()
            print("User Fetched: \(user)")
        }
    }

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

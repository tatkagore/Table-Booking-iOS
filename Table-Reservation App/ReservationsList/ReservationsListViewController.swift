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

    var myAccountButton: MyAccountButton = {
        let button = MyAccountButton(type: .system)
        button.setIcons(leftIcon: UIImage(systemName: "person.crop.circle"), rightIcon: UIImage(systemName: "chevron.right"), title: "My Account", subtitle: "Make changes to your account")
        return button
    }()

    var yourBookingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Your bookings"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.myGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setUpConstraints()
        presenter.onViewDidLoad()
        presenter.userDidLoad()
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

    private func configureButton() {
        // Set the callback
        myAccountButton.onRightButtonTapped = { [weak self] in
            guard let self = self, let user = self.user else { return }

            let userProfileViewController = UserProfileViewController()
            userProfileViewController.user = user
            self.navigationController?.pushViewController(userProfileViewController, animated: true)
        }
    }

    // MARK: - Auto Layout

    private func setUpConstraints() {
        view.addSubview(tableView)
        view.addSubview(myAccountButton)
        view.addSubview(yourBookingsLabel)
        myAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myAccountButton.topAnchor.constraint(equalTo: userCardView.bottomAnchor, constant: 20),
            myAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myAccountButton.heightAnchor.constraint(equalToConstant: 80),

            yourBookingsLabel.topAnchor.constraint(equalTo: myAccountButton.bottomAnchor, constant: 20),
            yourBookingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yourBookingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            tableView.topAnchor.constraint(equalTo: yourBookingsLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteHandler: (UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void = {[weak self] _,_, completion in
            guard let reservation = self?.reservations[indexPath.row] else {
                return
            }
            // Create an alert
            let alert = UIAlertController(title: "Delete Reservation", message: "Are you sure you want to delete this reservation?", preferredStyle: .alert)

            // Add a "Cancel" action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                completion(false)
            }))

            // Add a "Delete" action
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                // notify presenter about action 'delete'
                self?.presenter.deleteReservation(with: reservation)
                completion(true)
            }))

            // Present the alert
            self?.present(alert, animated: true, completion: nil)
        }

        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: deleteHandler)
        let actions: [UIContextualAction] = [delete]

        let swipeAction = UISwipeActionsConfiguration(actions: actions)

        return swipeAction
    }
}

//
//  HomeViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import UIKit

protocol HomeDisplayer: AnyObject {
    func showUser(_ user: UserModel)
    func showError(_ error: Error)
}

protocol HomePresenterDelegate: AnyObject {
}

class HomeViewController: UIViewController, HomePresenterDelegate {

    var presenter: HomePresenter = HomePresenterImpl()
    var user: UserModel?

    var helloUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var userProfileButton: profileButton = {
        let button = profileButton()
        // Set the image for the button
        let buttonImage = UIImage(named: "avatar")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(userProfileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        title = "Book a table" // Initialize the title
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(helloUserNameLabel)
        view.addSubview(userProfileButton)
        presenter.bind(displayer: self)
        setUpConstraints()
        presenter.onViewDidLoad()
    }

    @objc func userProfileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.user = user
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
}

extension HomeViewController: HomeDisplayer {
    func showError(_ error: Error) {
        print("User data fetching error: \(error.localizedDescription)")

    }

    func showUser(_ user: UserModel) {
        // Update the UI on the main thread
        DispatchQueue.main.async { [weak self] in
            self?.user = user
            if let firstName = user.firstName {
                self?.helloUserNameLabel.text = "Welcome, \(firstName)"
            }
        }
    }
}

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
    var user: UserModel?
    let logOutButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var presenter: HomePresenter = HomePresenterImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        title = "Hello, " // Initialize the title
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(logOutButton)
        presenter.bind(displayer: self)
        setUpConstraints()
        presenter.onViewDidLoad()
    }

    @objc
    func logOutButtonTapped() {
        let authManager = KeychainHelper()
        do {
            try authManager.logout()
            // Log success
            print("Token deleted from Keychain")
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        } catch {
            // Handle the error if logging out fails
            print("Error logging out: \(error.localizedDescription)")
        }
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
                self?.title = "Hello, \(firstName)"
            }
        }
    }
}

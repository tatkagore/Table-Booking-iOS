//
//  HomeViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import UIKit

class HomeViewController: UIViewController {

    let logOutButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("log out", for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Hiding the existing back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "Home screen"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(logOutButton)
        setUpConstraints()

    }

    @objc
    func logOutButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
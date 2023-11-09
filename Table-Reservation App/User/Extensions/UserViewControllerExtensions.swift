//
//  UserViewControllerExtensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/11/2023.
//

import Foundation
import UIKit

extension UserProfileViewController {
    // MARK: - Auto Layout

    func setUpConstraints() {
        // Create a stack view to stack the text fields and the "Update" button vertically
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, phoneNumberTextField, updateAccountButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let bottomStackView = UIStackView(arrangedSubviews: [logOutButton])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 20
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(bottomStackView)
        view.addSubview(stackView)
        view.addSubview(serverResponceLabel)


        NSLayoutConstraint.activate([
            // Center the stack view vertically
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Center the stack view horizontally
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            serverResponceLabel.topAnchor.constraint(equalTo: updateAccountButton.bottomAnchor, constant: 16),
            serverResponceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Center the stack view horizontally
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)

        ])
    }
}



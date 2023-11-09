//
//  UserViewControllerExtensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/11/2023.
//

import Foundation
import UIKit

extension UserViewController {
    // MARK: - Auto Layout

    func setUpConstraints() {
        // Create a stack view to stack the text fields and the "Update" button vertically
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, phoneNumberTextField, updateAccountButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            // Center the stack view vertically
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Center the stack view horizontally
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}



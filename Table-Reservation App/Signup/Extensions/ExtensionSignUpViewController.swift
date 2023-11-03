//
//  Extensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 02/11/2023.
//

import Foundation
import UIKit

extension SignUpViewController {
    // MARK: - Auto Layout

    func setUpConstraints() {
        // Create a stack view to stack the text fields vertically
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, phoneNumberTextField, createAccountButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let stackViewHorizontal = UIStackView(arrangedSubviews: [alredyHaveAccountLabel, backToLogin])
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.alignment = .center
        stackViewHorizontal.spacing = 10
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        view.addSubview(stackViewHorizontal)

        NSLayoutConstraint.activate([
            // Center the stack view vertically
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Center the stack view horizontally
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Add the horizontal stackView for "Don't have an account? Sign up" label and "SignUp" button
            stackViewHorizontal.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20),
            stackViewHorizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor)


        ])
    }
}



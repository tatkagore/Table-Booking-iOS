//
//  Extensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import Foundation
import UIKit


extension LoginViewController {
    // MARK: - Auto Layout
    
    func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInLabel.topAnchor.constraint(equalTo: welcomeBackLabel.bottomAnchor, constant: 10), // Adjust the constant to add space
            logInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            usernameTextField.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 20), // Adjust the constant to add space
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Add the horizontal stackView for "Don't have an account? Sign up" label and "SignUp" button
            stackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}



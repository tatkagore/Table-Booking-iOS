//
//  SignUpViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 02/11/2023.
//

import Foundation

import UIKit

class SignUpViewController: UIViewController {

    let firstNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()


    let lastNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let phoneNumberTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Phone Number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let emailTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let createAccountButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.addTarget(self, action: #selector(createAccountButtonTapper), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let alredyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Alredy have an account?"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let backToLogin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.myBlue, for: .normal)
        button.addTarget(self, action: #selector(backToLoginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create an account"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
        view.backgroundColor = .systemBackground
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(createAccountButton)
         setUpConstraints()

    }

    // MARK: - Actions

    @objc
    func createAccountButtonTapper() {
        print("CREATED Account")
    }

    @objc
    func backToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}





// Hiding the existing back button


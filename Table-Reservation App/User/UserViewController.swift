//
//  File.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation
import UIKit


class UserViewController: UIViewController {

    // MARK: - Properties

    let firstNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Update Your First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()


    let lastNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Update Your Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    let phoneNumberTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Update Your Phone Number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let emailTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Update Your Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Update Your Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    let updateAccountButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(updateAccountButtonTapper), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile" 
        view.backgroundColor = .systemBackground
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(updateAccountButton)
        setUpConstraints()
    }

    // MARK: - Actions

    @objc
    func updateAccountButtonTapper() {
        print("Updated Account")
    }
}

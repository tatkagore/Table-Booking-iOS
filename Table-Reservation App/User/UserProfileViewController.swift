//
//  File.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation
import UIKit

protocol UserProfileDisplayer: AnyObject {
    // display errors during updateUser profile
    func updateSuccessful(with user: UserModel)
    func updateFailed(with error: Error)
    func showMessageSuccessful(with message: String)
    func showMessageFail(with message: String)

}

protocol UserProfilePresenterDelegate: AnyObject {
}


class UserProfileViewController: UIViewController {

    // MARK: - Properties

    var user: UserModel?
    //
    var presenter: UserPresenter = UserPresenterImpl()

    let serverResponceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

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
    let logOutButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
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
        view.addSubview(serverResponceLabel)
        view.addSubview(logOutButton)

        presenter.bind(displayer: self)
        setUpConstraints()
        firstNameTextField.text = self.user?.firstName
        lastNameTextField.text = self.user?.lastName
        emailTextField.text = self.user?.email
        phoneNumberTextField.text = self.user?.phoneNumber
        passwordTextField.isSecureTextEntry = true
    }

    // MARK: - Actions

    @objc
    func updateAccountButtonTapper() {
        // we don't want t o make a req if these fields are empty

      guard let email = emailTextField.text, !email.isEmpty,
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let phoneNumber = phoneNumberTextField.text, !lastName.isEmpty else {
            return
        }

        let password = passwordTextField.text
        let updateUser: UserModel?

        if ((password?.isEmpty) != nil) {

            updateUser = UserModel(id: user?.id, isAdmin: user?.isAdmin, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
        } else {
            updateUser = UserModel(id: user?.id, isAdmin: user?.isAdmin, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password)
        }
        presenter.didTapUpdate(with: updateUser!)
    }
    @objc
    func logOutButtonTapped() {
        let authManager = KeychainHelper()
        do {
            try authManager.logout()
            // Log success
            print("Token deleted from Keychain")
            let presenter = LoginPresenterImpl(navigationController: navigationController!)
            self.navigationController?.pushViewController(LoginViewController(presenter: presenter), animated: true)
        } catch {
            // Handle the error if logging out fails
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}

extension UserProfileViewController: UserProfileDisplayer {

    func updateSuccessful(with user: UserModel) {
            self.user = user
    }

    func updateFailed(with error: Error) {
            self.showMessageFail(with: "Update failed")
    }

    func showMessageSuccessful(with message: String) {
        serverResponceLabel.text = message
        serverResponceLabel.isHidden = false
        serverResponceLabel.textColor = UIColor.myGreen

    }
    func showMessageFail(with message: String) {
        serverResponceLabel.text = message
        serverResponceLabel.isHidden = false
        serverResponceLabel.textColor = UIColor.myRed

    }
}

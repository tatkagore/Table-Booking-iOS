//
//  LoginViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//
import UIKit

// Protocol to define methods for displaying the login interface
protocol LoginDisplayer: AnyObject {
    func setup()
}

class LoginViewController: UIViewController {

    // MARK: - Properties

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(LoginViewController.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let presenter: LoginPresenter = LoginPresenterImpl()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        // Bind the view (self) to the presenter
        presenter.bind(displayer: self)
        setupConstraints()
    }

    // MARK: - Actions

    @objc func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Handle empty fields, show an alert, or provide user feedback
            return
        }

        let loginModel = LoginModel(username: username, password: password)

        // Call the presenter's login method
        presenter.login(with: loginModel) { [weak self] result in
            switch result {
            case .success(let message):
                // Handle successful login (e.g., navigate to the next screen)
                print(message)
                // Replace this with your navigation code
            case .failure(let error):
                // Handle login error (e.g., show an error message)
                print("Login error: \(error.localizedDescription)")
                // Replace this with your error handling code
            }
        }
    }


}

extension LoginViewController: LoginDisplayer {
    func setup() {
        // Implement any setup logic here if needed
    }
}


extension LoginViewController {
    // MARK: - Auto Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

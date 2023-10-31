//
//  LoginViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//
import UIKit

// Protocol to define methods for displaying the login interface
protocol LoginDisplayer: AnyObject {
}

// Protocol to define methods for handling login-related events
protocol LoginPresenterDelegate: AnyObject {
    func loginSuccessful(with token: String)
    func loginFailed(with error: Error)
}

class LoginViewController: UIViewController, LoginDisplayer {

    // MARK: - Properties

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
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

    var presenter: LoginPresenter = LoginPresenterImpl()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        presenter.delegate = self


        // Bind the view (self) to the presenter
        presenter.bind(displayer: self)
        setupConstraints()
    }

    // MARK: - Actions
    @objc
    func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }

        let loginModel = LoginModel(email: email, password: password)
        presenter.didTapLogin(with: loginModel)
    }


}


extension LoginViewController: LoginPresenterDelegate {
    // Implement the delegate methods for successful and failed logins
    func loginSuccessful(with message: String) {
        print("login successful")

        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            homeViewController.welcomeMessage = message
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }

    func loginFailed(with error: Error) {
        // Handle login failure, e.g., display an alert
        print("Login error: \(error.localizedDescription)")
    }
}

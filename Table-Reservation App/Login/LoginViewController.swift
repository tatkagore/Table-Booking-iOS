//
//  LoginViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//
import UIKit

// Protocol to define methods for displaying the login interface
protocol LoginDisplayer: AnyObject {
    // display errors during login
}

// Protocol to define methods for handling login-related events
protocol LoginPresenterDelegate: AnyObject {
    func loginSuccessful()
    func loginFailed(with error: Error)
}

class LoginViewController: UIViewController, LoginDisplayer {

    // MARK: - Properties

    let welcomeBackLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Login to your account"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .light) // Use a lighter font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let usernameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Username"
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

    let loginButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.myBlue, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()



    var presenter: LoginPresenter = LoginPresenterImpl()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logInLabel)
        view.addSubview(welcomeBackLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(dontHaveAccountLabel)
        view.addSubview(signUpButton)

        presenter.delegate = self


        // Bind the view (self) to the presenter
        presenter.bind(displayer: self)
        setupConstraints()
    }

    // MARK: - Actions
    @objc
    func loginButtonTapped() {
        guard let email = usernameTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }

        let loginModel = LoginModel(email: email, password: password)
        presenter.didTapLogin(with: loginModel)
    }
    @objc
    func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }


}


extension LoginViewController: LoginPresenterDelegate {
    func loginSuccessful() {
        print("login successful")

        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }

    func loginFailed(with error: Error) {
        // Handle login failure, e.g., display an alert
        print("Login error: \(error.localizedDescription)")
    }
}

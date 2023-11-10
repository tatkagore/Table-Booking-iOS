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
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
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
    // Button to SignUp view
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.myBlue, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var presenter: LoginPresenter

    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.backgroundColor = .white
        view.addSubview(logInLabel)
        view.addSubview(welcomeBackLabel)
        view.addSubview(emailTextField)
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
        guard let email = emailTextField.text, !email.isEmpty,
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

    func loginFailed(with error: Error) {
        // Handle login failure, e.g., display an alert
        print("Login error: \(error.localizedDescription)")
    }
}

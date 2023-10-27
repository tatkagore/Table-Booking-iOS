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
    func show(viewController: UIViewController)
}

class LoginViewController: UIViewController {

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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let presenter: LoginPresenter = LoginPresenterImpl()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // Bind the view (self) to the presenter
        presenter.bind(displayer: self)
        setupConstraints()        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

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

extension LoginViewController: LoginDisplayer {
    func show(viewController: UIViewController) {
        DispatchQueue.main.async {
            
            self.navigationController?.pushViewController(viewController, animated: true)
//            print("Login error: \(error.localizedDescription)")
        }

    }
    
    func setup() {
        // Implement any setup logic here if needed
    }
}

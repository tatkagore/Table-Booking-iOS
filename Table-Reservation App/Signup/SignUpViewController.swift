//
//  SignUpViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 02/11/2023.
//

import UIKit


// Protocol to define methods for displaying the signUp interface
protocol SignUpDisplayer: AnyObject {
    // display errors during sign up
}
// Protocol to define methods for handling signUp-related events
protocol SignUpPresenterDelegate: AnyObject {
    func signUpSuccessful(withAuthToken: String)
    func signUpFailed(with error: Error)
}


class SignUpViewController: UIViewController, SignUpDisplayer {
    
    // MARK: - Properties
    
    let firstNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    let lastNameTextField: StyledTextField = {
        let textField = StyledTextField()
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
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
    
    var presenter: SignUpPresenter = SignUpPresenterImpl()
    
    
    // MARK: - View Lifecycle
    
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
        
        
        presenter.delegate = self
        presenter.bind(displayer: self)
        setUpConstraints()
        
    }
    
    // MARK: - Actions
    
    @objc
    func createAccountButtonTapper() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !lastName.isEmpty else {
            return
        }
        let signUpModel = SignUpModel(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        presenter.didTapSignUp(with: signUpModel)
    }
    
    @objc
    func backToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SignUpViewController: SignUpPresenterDelegate {
    func signUpSuccessful(withAuthToken authToken: String) {
        
        let authManager = KeychainHelper()
        do {
            try authManager.saveTokenToKeychain(token: authToken)
            // Log success
            print("Token saved to Keychain")
            
        } catch {
            // Handle the error if saving the token fails
            print("Error saving token to Keychain: \(error.localizedDescription)")
        }
        print("signUpSuccessful")
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    func signUpFailed(with error: Error) {
        // Handle login failure, e.g., display an alert
        print("Login error: \(error.localizedDescription)")
    }
}
